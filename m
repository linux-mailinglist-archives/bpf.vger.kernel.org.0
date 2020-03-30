Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37701197F4D
	for <lists+bpf@lfdr.de>; Mon, 30 Mar 2020 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727717AbgC3PNa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 30 Mar 2020 11:13:30 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:46729 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727183AbgC3PNa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 30 Mar 2020 11:13:30 -0400
Received: by mail-lf1-f45.google.com with SMTP id q5so14470704lfb.13
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2020 08:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=3zhHJ/DCytaCuAszpbS/hUFHNDzc25lAR/e+TAM3FvA=;
        b=b1g9mfT7+hCJlZ2qKk1A2/KjSmDhfhZrp2k/QDB+GoMe90XDjvZVpTkD1Quqq8RXPG
         XHMeNUG2lsx18PPqEb2RZqtPBkQFuFdZh+8WyOuEy7idAV4NA4DHje1v6tdPNbchsRMU
         sPJrqjE5q12hNhdwtWRlqF7dde0qTvvn9zvzMEippqW90FtsUx850yV2dNPO/4Ao2+19
         0WiEptGZgp6aorkn2G2R7hZxA4LH7dPeMBGGIr0Sz6x11s2ohtEMHU/VKTK13fPuFByi
         oc/VeE5DdstAXj5NMymPjtoQDMzExDNY83Hb6TvQk3QmEEGV8W+jnf0ukmaVpvr9ZiIH
         roiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=3zhHJ/DCytaCuAszpbS/hUFHNDzc25lAR/e+TAM3FvA=;
        b=g04Ziht+GdtPKNtAd/g1izEdEvX4H7+P1yHOs8gneUbfp3WQUjLivbTyWE7KHEXm66
         e3LMGmoxknvuf6VOzppho5MsisjyiI7e2hPlLfWdumfRUiMgCDLQfH4/0fNfSHrAhSgV
         nhbj+AQs4ovf3lpODC9lUOLjkLXDPucmFIJeUrx5awiTxKWLce8QmqXRB2lcuX4kSwVf
         4MSZkCioJJfGBKad+VVQOuRT6/tINxnkrsUVdxGfaHpDmgaYm5r1sHAm2rRjXdEmqPf7
         YzCD7tzH9dUNUXY9IQo68Kz01lYORZ/A7c/9CO2pV85sqUb8cJMWP9IQvMSbZ+ow2sWN
         TrDg==
X-Gm-Message-State: AGi0PuZUOT41Wc2Y4ny0r2YzfRg5Hl1yho6PX+w9Y1woiCHvLMNIGaGv
        YoyDWiGyVSSfmxxq8ab/j1g8ndiRdziD+O0GQ9mFT0EAE8g=
X-Google-Smtp-Source: APiQypKjh+WkyDatfuRaqsJIWVYj6833rQXqHPTM2kFjV1K+d/bJb+qjmVUlb8InVLbgDDlgjgBnfuaImpmvoCN6QG4=
X-Received: by 2002:ac2:5ede:: with SMTP id d30mr8236138lfq.157.1585581204841;
 Mon, 30 Mar 2020 08:13:24 -0700 (PDT)
MIME-Version: 1.0
From:   Jann Horn <jannh@google.com>
Date:   Mon, 30 Mar 2020 17:12:58 +0200
Message-ID: <CAG48ez2sZ58VQ4+LJu39H1M0Y98LhRYR19G_fDAPJPBf7imxuw@mail.gmail.com>
Subject: CONFIG_DEBUG_INFO_BTF and CONFIG_GCC_PLUGIN_RANDSTRUCT
To:     bpf@vger.kernel.org,
        Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

I noticed that CONFIG_DEBUG_INFO_BTF seems to partly defeat the point
of CONFIG_GCC_PLUGIN_RANDSTRUCT.

CONFIG_GCC_PLUGIN_RANDSTRUCT randomizes the layout of (some)
kernel-internal structs, which AFAIK is intended to make exploitation
harder in two ways:
1) by ensuring that an attacker can't use a single exploit relying on
specific structure offsets against every target
2) by keeping structure offsets secret from the attacker, so that the
attacker can't rely on knowledge of structure offsets even when trying
to exploit a specific target - only relevant for the few people who
build their kernel themselves (since nobody was crazy enough to
implement generating relocations for structure offsets so far).

When CONFIG_DEBUG_INFO_BTF is on, the kernel exposes the layouts of
kernel structures via the mode-0444 file /sys/kernel/btf/vmlinux, so a
local attacker can easily see structure offsets, defeating part 2.

I wonder whether these kconfig knobs should be mutually exclusive, or
whether /sys/kernel/btf/vmlinux should have a different mode, or
something like that.

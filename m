Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54130352D
	for <lists+bpf@lfdr.de>; Tue, 26 Jan 2021 06:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732901AbhAZFg7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 26 Jan 2021 00:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728591AbhAYNH6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jan 2021 08:07:58 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E1DC0613D6
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 05:06:36 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id h25so3689768wmb.6
        for <bpf@vger.kernel.org>; Mon, 25 Jan 2021 05:06:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=rvdd/QvafmjAw8kwJuM2WPMcObpLsH4hFPPapXqLuVw=;
        b=S7ZLKuJE2Nw0VX4gSdpTscLmFP0oSOsFalu+BDYlo+H04JU5zRMmwbpnfcya25COfc
         J9W8trwf/1gwvDti53XoNWqutktpB9FRu3Fvz4RWnLkn9NqSI0pd9C4Zcei7aottSJGp
         opmIYefCbdF+BfsI/U52Jc0BxkomJlWn5/rdp4jB7HoWvQhCF68RrQS7EFG2br3DHxZi
         fpGrlBIpmDDMJC6u+e/ze2HE+nCCPnI0CcwXgYsq5nsprOmCvS29uTGsUUa9wWIPrQee
         dJphcXYSkLtPKSp4XmzeG4oZW6T0MFK6FegzQnBo+oMPVD1IDKWfgLd63ccRs8BSe5j7
         enTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=rvdd/QvafmjAw8kwJuM2WPMcObpLsH4hFPPapXqLuVw=;
        b=X+aFKRk7iQza0Aq/tyIT6rHnrBhHLqJAcCQJw5XILMJ0Wh3ijgK095AEY0ZUh9yVk4
         SlTr8mGqF890g34rgJHXdZfeP92RjffKct4+S45O/t68naOq0rHtLRMPdpdVC8k4vtZ7
         YfVsIApybG2Fe7hbOV6OL3AHDVcgOl9p0vAkUY21uUTCSR9VKa5KIq3A32bLHJmr6YB8
         o0KGDj2blsuTraTSSj2oDanjnwQoSJ+8dVPsRjvuoQ88DzFBmpWZ/FsGntWE5+TQ2VTI
         r7D+DUW4kwy7Bvvru0MNBBzblnBPt8dwVCKrpd8jYpnTFQvnm5GXX2VXi3O5IJvBg9GT
         JONA==
X-Gm-Message-State: AOAM5325nZSA6csxI8cbqgtbMX0K9wAGnJHw0FJpheZkJE2fSGl4xhxJ
        ChzvaPEptqZyOWa3fa3HL3s+SoakQJl2Gg==
X-Google-Smtp-Source: ABdhPJzZ9wQdK3n/uMg8qE3gXor6Gv/nkJNGKknao7LqdRUWRx57fl9nXRn0QuDLbf0Po+yjPljRVYoKyVd6hQ==
Sender: "gprocida via sendgmr" <gprocida@tef.lon.corp.google.com>
X-Received: from tef.lon.corp.google.com ([2a00:79e0:d:110:a6ae:11ff:fe11:4f04])
 (user=gprocida job=sendgmr) by 2002:a1c:1f11:: with SMTP id
 f17mr32811wmf.67.1611579995009; Mon, 25 Jan 2021 05:06:35 -0800 (PST)
Date:   Mon, 25 Jan 2021 13:06:21 +0000
Message-Id: <20210125130625.2030186-1-gprocida@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.0.280.ga3ce27912f-goog
Subject: [PATCH dwarves 0/4] BTF ELF writing changes
From:   Giuliano Procida <gprocida@google.com>
To:     dwarves@vger.kernel.org
Cc:     acme@kernel.org, andrii@kernel.org, ast@kernel.org,
        gprocida@google.com, maennich@google.com, kernel-team@android.com,
        kernel-team@fb.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi.

This follows on from my change to improve the error handling around
llvm-objcopy in libbtf.c.

Note on recipients: Please let me know if I should adjust To or CC.

Note on style: I've generally placed declarations as allowed by C99,
closest to point of use. Let me know if you'd prefer otherwise.

1. Improve ELF error reporting

2. Add .BTF section using libelf

This shows the minimal amount of code needed to drive libelf. However,
it leaves layout up to libelf, which is almost certainly not wanted.

As an unexpcted side-effect, vmlinux is larger than before. It seems
llvm-objcopy likes to trim down .strtab.

3. Manually lay out updated ELF sections

This does full layout of new and updated ELF sections. If the update
ELF sections were not the last ones in the file by offset, then it can
leave gaps between sections.

4. Align .BTF section to 8 bytes

This was my original aim.

Regards.

Giuliano Procida (4):
  btf_encoder: Improve ELF error reporting
  btf_encoder: Add .BTF section using libelf
  btf_encoder: Manually lay out updated ELF sections
  btf_encoder: Align .BTF section to 8 bytes

 libbtf.c | 222 +++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 175 insertions(+), 47 deletions(-)

-- 
2.30.0.280.ga3ce27912f-goog


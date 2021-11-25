Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D26D545D64C
	for <lists+bpf@lfdr.de>; Thu, 25 Nov 2021 09:36:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350388AbhKYIjl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Nov 2021 03:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352750AbhKYIiM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Nov 2021 03:38:12 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A018BC061759
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 00:35:01 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id u3so14387294lfl.2
        for <bpf@vger.kernel.org>; Thu, 25 Nov 2021 00:35:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=ZrLRMGglwSYW/GrbGuymwfxTUNc8BQ+Pt/JJxD1BNmU=;
        b=WHmHb/Qhr5ypJcaO7+1J/4yNo7wgJHw4zIO3a3ZgePyw7Z8AW2xfqv8apEelnT3/TG
         9tnjMHtvYpQKZZ2i0bGROOmdNceKAoyGnJ9Myo3NMb7FQgYeXGiVmVI5GYJLLJJLY7d6
         OUA/bKIybx+a5YA7aUdcqZ/OjM8Ni9zLWs6rW+W3c7l6VRLSF0vnUdwVSCr9UqtHr6Az
         bp0foC0/dcrori8iTS8l7ZBXWt/GB5BSrcaUG5LTaLwv8+7NGIs9udY7qvw9PxT3YY4F
         opO6fUMVfPMBNGeVQ4dNIVlgLMBYbQw9rzO22UZyH0fPNmrOUlN7tNBrrye1gGSBpggW
         EOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=ZrLRMGglwSYW/GrbGuymwfxTUNc8BQ+Pt/JJxD1BNmU=;
        b=nWqyv3KfVosjh0XZSTlgY6CCT9FRmz3Pwfn3/6+NVudMbG3AgiLJnj0BGtYRLThnzv
         ilRnafhYBTeTVFIKkG2OXiheBbSzQva1HuYSVsmze5MRL7X6yM5c5ZedUjjv2nqHv/4x
         h8jUPqmTTS2PZNY1yhn1plH0ELBlk9GBuyZB6pHW5SqjDJDEc7bTrB+vRC+ZnBLSpnsV
         lPntjfd+ZWHyVaS7Qy8TO4dOXe9l3gzica8gPTjuzlU5NS/Zvgf58X4t9qcepz8mftPO
         iBAWuPfZaGQZfqx9OKbALKEahRb6ccB5uiro3xcZDOiXdCAjOyaPMv+EVZMMOMKKOaft
         bTBg==
X-Gm-Message-State: AOAM531Ku4wHQt5n6RmrFtCVT4BqeN/ociUzreEMlxTHJ25xQm4an6H1
        Wy5yNm2FEpEsRtNSGkwqvnCsrt53lG7BZ4lkanulU6p0LRNY4Q==
X-Google-Smtp-Source: ABdhPJyb+404wve10ngOjtIGSGV9jS47WS2jLhTzkA4Fg15lL/XkRxBZwf83rhPyRZlPwAOFvQ+X98Qh73BLDwwfSEI=
X-Received: by 2002:a05:6512:3090:: with SMTP id z16mr22350337lfd.335.1637829299834;
 Thu, 25 Nov 2021 00:34:59 -0800 (PST)
MIME-Version: 1.0
From:   Yahui Chen <goodluckwillcomesoon@gmail.com>
Date:   Thu, 25 Nov 2021 16:34:48 +0800
Message-ID: <CAPydje8FKWzRCR33RanGZkucavFZNb2zSGhfQdrd49Uvgc2YxQ@mail.gmail.com>
Subject: can add a new bpf helper function bpf_map_compare_and_update_elem?
To:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Cc:     zhangwei123171@jd.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Suppose we have a map, MAP_A, and the user program does the following:

1. bpf_map_lookup_elem(MAP_A, key, value)
2. change the value
3. bpf_map_update_elem(MAP_A, key, value, FLAG)

At the same time, the kernel's BPF program may also be modifying the value.

Then we have concurrency problems.

Therefore, can we add a helper function like compare and swap?

Let's call it bpf_map_compare_and_update_elem.

So, the map operations will be modified as follows:

for true {
    1. bpf_map_lookup_elem(MAP_A, key, old_value)
    2. change value
    3. ret = bpf_map_compare_and_update_elem(MAP_A, key, old_value,
new_value, FLAG)
    4. if ret == 0 { break }
}


thank you

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003EE4B585A
	for <lists+bpf@lfdr.de>; Mon, 14 Feb 2022 18:19:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345343AbiBNRUG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Feb 2022 12:20:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbiBNRUF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Feb 2022 12:20:05 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB3B652C4
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 09:19:57 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id h7so20740945iof.3
        for <bpf@vger.kernel.org>; Mon, 14 Feb 2022 09:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=OJoxs7y2kmPfa8lHGGvDFwbCvSCiPlFjTDfF0orZDFc=;
        b=WeuSTFm/wipd+ScRw4uofQelmGUSTCEROP3ySgVY/lZj4+Yw6SrEXEf47C7lTHMHZD
         QYhK/USbM3hbw3egKYuHM+NkCTgx/vzuq0pppAsx/NiuNRiGIacRYzkj1RxYPn+o59nX
         Br2jgm0WRNI37Tr2XNaePHb1q77NgDdwRgsIfkFEYiJxYadgxq2SU7i7G6SMl8snVukI
         n1s2EoZNFuDStDgZw8XUlFrftZtHQUufkERqw04cZ7NN4YBUT1NwV2hjjE2c20bkSZ4j
         G3QooZKSHDQXXHiTjdRTY/hHofoHf6z/pNGIMcLN31jVyH1jsCcU4TV9hPuyWofZ4kWz
         aXZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=OJoxs7y2kmPfa8lHGGvDFwbCvSCiPlFjTDfF0orZDFc=;
        b=rTGQw0JK81F9hKZ8h9p8a632/U7Yee3MYWLok3i0FgrPglwdfsoPvBRi6fWshoKyLv
         4099JAeRapPpJPDlqSztbBXNySqsRifst581kSlO0gCdtqNfP1nNRkFM7t6fL2LVeytA
         fuHn07YBiQajChu9Lwaklj5qAbYdJlWvyuvylXAnYXRURy2SVpLXR+Sr/fF6G4uZr5Oe
         51jJWFJ+mg0eQUa5vMUXhbxM+SnHgs7nnBN5zfoOI9OBqf+ycspCj0u3aysL9QlXNzvu
         Rn7yMfMVmcMzF+46hQ3606vOXj6OvCkYPiWcs+jhnHq3jQpnB7/EcTTELpZS9z8goSDU
         e9pg==
X-Gm-Message-State: AOAM532wRfyNrGcMkon/kAPFnOqnOVAjYA+/JXKXYvgY0LNBCeQsvVnB
        iwiHcPWPj86fy0cjsJ8H8vo=
X-Google-Smtp-Source: ABdhPJwjCJduN5Ezw5dl3Z2/nCO0DXv8UBfSx26zotOJf6ueaU/eP60OPx1dA4IR1EK5iLDbuFh1sw==
X-Received: by 2002:a05:6602:1656:: with SMTP id y22mr512607iow.34.1644859196525;
        Mon, 14 Feb 2022 09:19:56 -0800 (PST)
Received: from localhost ([99.197.200.79])
        by smtp.gmail.com with ESMTPSA id n12sm19869458ili.69.2022.02.14.09.19.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:19:56 -0800 (PST)
Date:   Mon, 14 Feb 2022 09:19:47 -0800
From:   John Fastabend <john.fastabend@gmail.com>
To:     Felix Maurer <fmaurer@redhat.com>, bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, davemarchevsky@fb.com
Message-ID: <620a8f3381929_2bedb20899@john.notmuch>
In-Reply-To: <89f767bb44005d6b4dd1f42038c438f76b3ebfad.1644601294.git.fmaurer@redhat.com>
References: <89f767bb44005d6b4dd1f42038c438f76b3ebfad.1644601294.git.fmaurer@redhat.com>
Subject: RE: [PATCH bpf-next] selftests: bpf: Check bpf_msg_push_data return
 value
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Felix Maurer wrote:
> bpf_msg_push_data may return a non-zero value to indicate an error. The
> return value should be checked to prevent undetected errors.
> 
> To indicate an error, the BPF programs now perform a different action
> than their intended one to make the userspace test program notice the
> error, i.e., the programs supposed to pass/redirect drop, the program
> supposed to drop passes.
> 
> Fixes: 84fbfe026acaa ("bpf: test_sockmap add options to use msg_push_data")
> Signed-off-by: Felix Maurer <fmaurer@redhat.com>
> ---
>  .../selftests/bpf/progs/test_sockmap_kern.h   | 26 +++++++++++++------
>  1 file changed, 18 insertions(+), 8 deletions(-)

LGTM. As a general comment we should be looking to convert test_sockmap
over to the modern globals method to detect errors like used in all the
other tests. Also I've been considering porting the tests we need into
the more generally used test_progs framework. Or go the other way and
take some of the general functions used in test_prog and use them in
test_sockmap.

Right now code wise test_sockmap is a bit of an island. But, this patch
is good we shouldn't block small useful fixes because we are waiting for
me to conjure up some time to do a bigger overhaul. I mention in case
someone else is able to pick it up. Feel free to ping me if its
interesting. Otherwise I'll get to it when I can.

Acked-by: John Fastabend <john.fastabend@gmail.com>

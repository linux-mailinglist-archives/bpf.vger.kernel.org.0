Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A2B5A6E15
	for <lists+bpf@lfdr.de>; Tue, 30 Aug 2022 22:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231229AbiH3UEX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 30 Aug 2022 16:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiH3UEF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 30 Aug 2022 16:04:05 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571DC74E3B
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 13:03:03 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id h5so12805400ejb.3
        for <bpf@vger.kernel.org>; Tue, 30 Aug 2022 13:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metanetworks.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc;
        bh=nFL5GGMagdzz+ZCtLkxziHD3fT5LnC/vAXCT3QMakTk=;
        b=WQTKI+affLvPdQb/ZFiN6MrklTluWf9r3qAXo4nBm+b5GA04CSXYz6BWuzV0lfkd7+
         sGBsBdfPVUgGsRrHVgpD40fAhXiAPTGkO1/QQU28nqQM2kJPb1ACkvUw5ZKkqgmPw1SE
         /YZ5XrYVxN1hhVjS4pRP2x5fatC9OKRIr/Gs8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=nFL5GGMagdzz+ZCtLkxziHD3fT5LnC/vAXCT3QMakTk=;
        b=3OhOE2DgiAT2Pq7MWTnM8TeG3LZBM7mWrTsvFh8K1wa4XLjw3J+/P9RW8NyRMtZ5Gv
         Dy5/B3Pp/boEY9jy7gLunLBOAGhh0auYDMAywyXKIKlFWRPTyKVEDCe7G7x16nsK1tyg
         MaQL/zxoQIWTr3u5UrztLxfKahy2yjhH5H60qtkwGkfijg+naLAhYnTFGIyWKvThhkD2
         TIH4tzYkf6gTpYv9JWrz8eVQdxB8j9WhKSe3mHfKc86gEN4wDLLuyHXDtnwDUt8THD0i
         NSKfQLK7SHwpTFGbN+Xnog6K5e1alDNN83/1lXr5FW/jwQwqMlJKgyDc1JAjG7qT8quN
         iLxA==
X-Gm-Message-State: ACgBeo2v52k70v3LlGRMxCmQAGiLXzgc5aQH56eDqaOW8jStkJzTfC/B
        iaiotwku/vGBDOjD3q/LiAhmyw==
X-Google-Smtp-Source: AA6agR6VrZpAcXEICK9cUZ95EhLFkhstcI8aYtGULwYefyferHELSKH0OTBSODb2yWm/F/B5sUy5Kw==
X-Received: by 2002:a17:907:7fa7:b0:731:51b4:5020 with SMTP id qk39-20020a1709077fa700b0073151b45020mr17556281ejc.352.1661889781814;
        Tue, 30 Aug 2022 13:03:01 -0700 (PDT)
Received: from blondie ([5.102.239.127])
        by smtp.gmail.com with ESMTPSA id i23-20020a0564020f1700b00447f434e4d7sm7261759eda.20.2022.08.30.13.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 13:03:01 -0700 (PDT)
Date:   Tue, 30 Aug 2022 23:02:57 +0300
From:   Shmulik Ladkani <shmulik@metanetworks.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Joanne Koong <joannelkoong@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Paul Chaignon <paul@isovalent.com>,
        Shmulik Ladkani <shmulik.ladkani@gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/4] bpf: Support setting variable-length
 tunnel options
Message-ID: <20220830230257.67468080@blondie>
In-Reply-To: <CAEf4BzZKts8NckT7L-FWBRWJxAgkHEZoR=wjaKBxYpTD_jjyAg@mail.gmail.com>
References: <20220824044117.137658-1-shmulik.ladkani@gmail.com>
        <20220824044117.137658-3-shmulik.ladkani@gmail.com>
        <CAEf4BzZKts8NckT7L-FWBRWJxAgkHEZoR=wjaKBxYpTD_jjyAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 25 Aug 2022 11:20:31 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> > + * long bpf_skb_set_tunnel_opt_dynptr(struct sk_buff *skb, struct bpf_dynptr *opt, u32 len)  
> 
> why can't we rely on dynptr's len instead of specifying extra one
> here? dynptr is a range of memory, so just specify that you take that
> entire range?
> 
> And then we'll have (or partially already have) generic dynptr helpers
> to adjust internal dynptr offset and len.

Alright.

For my usecase I need to use *part* of the tunnel options that were
previously stored as a dynptr.

Therefore I need to introduce a new bpf helper that adjusts the dynptr.

How about this suggestion (sketch, not yet tried):

// adjusts the dynptr to point to *len* bytes starting from the
// specified *offset*

BPF_CALL_3(bpf_dynptr_slice, struct bpf_dynptr_kern *, ptr, u32, offset, u32, len)
{
	int err;
        u32 size;

	if (!ptr->data)
		return -EINVAL;

	err = bpf_dynptr_check_off_len(ptr, offset, len);
	if (err)
		return err;

	ptr->offset += offset;
	size = bpf_dynptr_get_size(ptr) - len;
	ptr->size = (ptr->size & ~(u32)DYNPTR_SIZE_MASK) | size;
	return 0;
}


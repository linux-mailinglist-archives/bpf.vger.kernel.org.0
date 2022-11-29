Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1E0163C84A
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 20:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiK2TZP (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 14:25:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236849AbiK2TYt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 14:24:49 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21F18748D1
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:22:16 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id ml11so11330192ejb.6
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 11:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=6at8/HCb/PbRLx6ylTXZMOhRBD/7rFseKJW3HPCTe60=;
        b=qdDEmBVEwBjpn0vHpjG/q+lG+kR34GDWU8YFN5K64M5wNyj3DSMvatmxzec+jPd6AD
         czmBqJpjkC5hXAfbEQlg1iMzv/IoOfm9hNE2MRMbOMnRU5MJO7u5k5/f/KVpd48EA1vo
         yoFxKYo1QClgULjj9vDSR2wy/Q7bN6YpPypIU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6at8/HCb/PbRLx6ylTXZMOhRBD/7rFseKJW3HPCTe60=;
        b=U7wF7HST+7xbk4rOAPDKEctu8T2lQR2Q6FtzK8Y5LSJTibcd2sPKwuz8a2Mp2fyhMP
         1/NBghQbav99rKUQkHojXLCY2V9VupCpP4tLBSxBiCRFn7t+kCl20fxoe9CRQyrCfsaF
         thsiEI3WgZXl2Dm4QypEl5HJh/tNJRRG9Koiy9670EZG/2+jnHbqc6vxFMzFMN2U1EQ/
         OHA5VM4PIoKmE8M+wcQxYKNr/TBfi/CY2+pUjn9k9GpVYIWELfQUYuzqRwm8Zurb8rAb
         t8pkqFx2TI2A7fOn8bdjSuTzg8azIwuVtlgP9nwS2tIGj/wsSiSuvIqBgCI735Z9FwQy
         Vn2w==
X-Gm-Message-State: ANoB5pnb9DobR3QaLVspDcHR9jasW1OoMDtLJ3hH5p0Z9d1z5lIa/k+O
        feJ0zbUW0scNUr31+dx+JJMRZnc0+T1GJQ==
X-Google-Smtp-Source: AA0mqf5/CS7mvw6m06Bj1RNLiD+ayMSq578qkQAjOLRP4gp05khST6o5eQoEooYkhHsbTiGzrDgV1Q==
X-Received: by 2002:a17:906:b241:b0:7bc:1f2c:41b5 with SMTP id ce1-20020a170906b24100b007bc1f2c41b5mr20586361ejb.463.1669749734744;
        Tue, 29 Nov 2022 11:22:14 -0800 (PST)
Received: from cloudflare.com (79.184.216.98.ipv4.supernova.orange.pl. [79.184.216.98])
        by smtp.gmail.com with ESMTPSA id t4-20020a17090605c400b00730bfe6adc4sm6515623ejt.37.2022.11.29.11.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Nov 2022 11:22:14 -0800 (PST)
References: <1669082309-2546-1-git-send-email-yangpc@wangsu.com>
 <1669082309-2546-3-git-send-email-yangpc@wangsu.com>
 <637d8d5bd4e27_2b649208eb@john.notmuch>
 <000001d8ff01$053529d0$0f9f7d70$@wangsu.com>
 <87cz97cnz8.fsf@cloudflare.com> <6384fb79f28f0_59da0208e7@john.notmuch>
User-agent: mu4e 1.6.10; emacs 27.2
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     Pengcheng Yang <yangpc@wangsu.com>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, 'Daniel Borkmann' <daniel@iogearbox.net>,
        'Lorenz Bauer' <lmb@cloudflare.com>
Subject: Re: [PATCH RESEND bpf 2/4] bpf, sockmap: Fix missing BPF_F_INGRESS
 flag when using apply_bytes
Date:   Tue, 29 Nov 2022 20:16:44 +0100
In-reply-to: <6384fb79f28f0_59da0208e7@john.notmuch>
Message-ID: <87r0xla7mi.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


On Mon, Nov 28, 2022 at 10:18 AM -08, John Fastabend wrote:
> Jakub Sitnicki wrote:
>> On Wed, Nov 23, 2022 at 02:01 PM +08, Pengcheng Yang wrote:
>> > John Fastabend <john.fastabend@gmail.com> wrote:

[...]

>> >> Now that we have a psock->flags we should clera that as
>> >> well right?
>> >
>> > According to my understanding, it is not necessary (but can) to clear
>> > psock->flags here, because psock->flags will be overwritten by msg->flags
>> > at the beginning of each redirection (in sk_psock_msg_verdict()).
>> 
>> 1. We should at least document that psock->flags value can be garbage
>>    (undefined) if psock->sk_redir is null.
>
> Per v2 I think we should not have garbage flags. Just zero the flags
> field no point in saving a single insn here IMO.

It would make sense to me if zero was not a valid value here. But since
it signifies "redirect to egress", we won't be able to tell if it has
been reset anyway.

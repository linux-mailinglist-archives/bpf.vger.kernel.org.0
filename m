Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E3E660603
	for <lists+bpf@lfdr.de>; Fri,  6 Jan 2023 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjAFRz1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 6 Jan 2023 12:55:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbjAFRzX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 6 Jan 2023 12:55:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A81D7D1C6
        for <bpf@vger.kernel.org>; Fri,  6 Jan 2023 09:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673027681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MuLENkNZ0UFRTMo6t5ih+jZeaau3XI+D4yJJLKbnE1o=;
        b=RMdP2NbxcHud1MoPx2gil/1jF/Uz4AJpsroPUqSrtLJHV9s51TRTvaBtg1sR9oDF70r+7B
        ohtsitB5ouako0DpFN/0XPt+Ctg5NzZaeLPdhHH3TiMg7gFypUaYLePFytKiwpBzscZ3we
        80E55zfZpP1S7WEWU1BPYRp9IfpHmTA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-116-SRdrxQdIOPyeIl0QURIsWQ-1; Fri, 06 Jan 2023 12:54:40 -0500
X-MC-Unique: SRdrxQdIOPyeIl0QURIsWQ-1
Received: by mail-ed1-f70.google.com with SMTP id y21-20020a056402359500b0048123f0f8deso1678224edc.23
        for <bpf@vger.kernel.org>; Fri, 06 Jan 2023 09:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MuLENkNZ0UFRTMo6t5ih+jZeaau3XI+D4yJJLKbnE1o=;
        b=J8U36ktlN0RYEwZAiHcXowVHaXo/zBDboACsGAlQTPgPGRhBcjBGMmhyQhH0d/1Lhv
         XVXeRB5HMHeQE8EhW1FUR4WuF62diIehoc6rgShpCh4UYgV65pRTDWdvq1WSarMxUC5U
         TDIHQfD3sZb6qMDfyz20lr0FaKrKuxqYaK8nT3Tm02IrB/kcZM7PxtnyYOEaaVCp+ae2
         MlUCDwvFuOAIZzX6TZELEDEMEFX58hbnmVFX5vNYPPgEGsVgwTHKFGk4Gs25Lr4KZXoJ
         9jTaw0C2jFFWG0ftCJGrmI/2O0p4zV/ql70Rb4h/dzQaZSAvTfV1tAP55V4t6NuIcLpU
         k4wg==
X-Gm-Message-State: AFqh2kqMVe/w6MqoGUpriRl8mAaqGoBnOh7F7PKE7n47kavUtKSDuIVx
        KP7E/B6yocuNcUJI90ngMYP1D1NAG9Mq5f0WJv7G/G3nwqVr98jFRLZrWIposV/o4ap1RUkYXNC
        QCTyUgX8Cd7YK
X-Received: by 2002:a17:906:8492:b0:7c0:affa:866f with SMTP id m18-20020a170906849200b007c0affa866fmr46685017ejx.26.1673027678999;
        Fri, 06 Jan 2023 09:54:38 -0800 (PST)
X-Google-Smtp-Source: AMrXdXviRuOVFvPsgZAiJO4FNCAdAjeKQ0e2Oa2rRLFcEdYw99NXt2TsB3XOjAbxkrELxWRDYBRVaw==
X-Received: by 2002:a17:906:8492:b0:7c0:affa:866f with SMTP id m18-20020a170906849200b007c0affa866fmr46684990ejx.26.1673027678752;
        Fri, 06 Jan 2023 09:54:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id k8-20020a17090632c800b00780982d77d1sm602967ejk.154.2023.01.06.09.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 09:54:37 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 059548DA101; Fri,  6 Jan 2023 18:54:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andy Gospodarek <andrew.gospodarek@broadcom.com>
Cc:     Tariq Toukan <ttoukan.linux@gmail.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Andy Gospodarek <andrew.gospodarek@broadcom.com>,
        ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        hawk@kernel.org, john.fastabend@gmail.com, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, lorenzo.bianconi@redhat.com,
        netdev@vger.kernel.org, bpf@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>, gal@nvidia.com,
        Saeed Mahameed <saeedm@nvidia.com>, tariqt@nvidia.com
Subject: Re: [PATCH net-next v2] samples/bpf: fixup some tools to be able to
 support xdp multibuffer
In-Reply-To: <87v8lkzlch.fsf@toke.dk>
References: <20220621175402.35327-1-gospo@broadcom.com>
 <40fd78fc-2bb1-8eed-0b64-55cb3db71664@gmail.com> <87k0234pd6.fsf@toke.dk>
 <20230103172153.58f231ba@kernel.org> <Y7U8aAhdE3TuhtxH@lore-desk>
 <87bkne32ly.fsf@toke.dk> <a12de9d9-c022-3b57-0a15-e22cdae210fa@gmail.com>
 <871qo90yxr.fsf@toke.dk> <Y7cBfE7GpX04EI97@C02YVCJELVCG.dhcp.broadcom.net>
 <87v8lkzlch.fsf@toke.dk>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 06 Jan 2023 18:54:37 +0100
Message-ID: <87k01zzgyq.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

>>> So my main concern would be that if we "allow" this, the only way to
>>> write an interoperable XDP program will be to use bpf_xdp_load_bytes()
>>> for every packet access. Which will be slower than DPA, so we may end up
>>> inadvertently slowing down all of the XDP ecosystem, because no one is
>>> going to bother with writing two versions of their programs. Whereas if
>>> you can rely on packet headers always being in the linear part, you can
>>> write a lot of the "look at headers and make a decision" type programs
>>> using just DPA, and they'll work for multibuf as well.
>>
>> The question I would have is what is really the 'slow down' for
>> bpf_xdp_load_bytes() vs DPA?  I know you and Jesper can tell me how many
>> instructions each use. :)
>
> I can try running some benchmarks to compare the two, sure!

Okay, ran a simple test: a program that just parses the IP header, then
drops the packet. Results as follows:

Baseline (don't touch data):    26.5 Mpps / 37.8 ns/pkt
Touch data (ethernet hdr):      25.0 Mpps / 40.0 ns/pkt
Parse IP (DPA):                 24.1 Mpps / 41.5 ns/pkt
Parse IP (bpf_xdp_load_bytes):  15.3 Mpps / 65.3 ns/pkt

So 2.2 ns of overhead from reading the packet data, another 1.5 ns from
the parsing logic, and a whopping 23.8 ns extra from switching to
bpf_xdp_load_bytes(). This is with two calls to bpf_xdp_load_bytes(),
one to get the Ethernet header, and another to get the IP header.
Dropping one of them also drops the overhead in half, so it seems to fit
with ~12 ns of overhead from a single call to bpf_xdp_load_bytes().

I pushed the code I used for testing here, in case someone else wants to
play around with it:

https://github.com/xdp-project/xdp-tools/tree/xdp-load-bytes

It's part of the 'xdp-bench' utility. Run it as:

./xdp-bench drop <iface> -p parse-ip

for DPA parsing and

./xdp-bench drop <iface> -p parse-ip -l

to use bpf_xdp_load_bytes().

-Toke


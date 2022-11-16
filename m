Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7F2962B6E4
	for <lists+bpf@lfdr.de>; Wed, 16 Nov 2022 10:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiKPJta (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 16 Nov 2022 04:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbiKPJt3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 16 Nov 2022 04:49:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81870266B
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 01:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668592116;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KEr65FftyAvd0R6Y1Vvx/V9RSQkCwNJYF7Ig4eQxDek=;
        b=iOJnvYO20iSHCCEAVB9dSyyKWCEnNyqns0XPBKC8vYWE1wVVpZvkugHHqITV4Wj9PikApC
        rhWirrPbY/rupDSzGeAeREmB8eThhaNXk9Ke7hCeGqNWIzijMz78rJs984seIMVUazgaHR
        lqSoglV6WtnBuyy8DLMN37jns2DDHF8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-264-EEaqbI5SM9eMbmzc3mGCgQ-1; Wed, 16 Nov 2022 04:48:35 -0500
X-MC-Unique: EEaqbI5SM9eMbmzc3mGCgQ-1
Received: by mail-ed1-f69.google.com with SMTP id b14-20020a056402278e00b004621a2642d7so11891843ede.1
        for <bpf@vger.kernel.org>; Wed, 16 Nov 2022 01:48:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KEr65FftyAvd0R6Y1Vvx/V9RSQkCwNJYF7Ig4eQxDek=;
        b=hDAB2NnnLVQY/cSMF8IAwDtMf5xVPsjQ/43MbMB02+SJ9q+RKXNpQ1O2Wc/ZiCq4TZ
         y1H3UzBzwnFbnfurwtVbSXPAkfPucSyDuqfh1PdIw0rqVH35p4sQ+zXWa9bLsn7naUWd
         wMDdEtq5ChMITIa4eR+R+IYon7xJsL+9MADaeYBEhftaAydIxGXFAljddJntuxsVo71W
         2L/IWOR244H0fLmC6zwZ2V669vHxtkUdiaq43WFiUI2chSYYuNuPtd6gjIArUZ1FLJho
         k455a6UcLzHC+do1svb7axgh1LqNgwjyhXz9hojXsdF2aSKk2PIwy3hdbZmk9rQsxyDg
         bmgw==
X-Gm-Message-State: ANoB5pmfnuQFfNg3ItkZpZu5xgF4wEc6dLeUVHv/v+yW/Ezv8frsm9pC
        52idAlCDoag/4OTNSCECoNq6ecFUhcFJ2c39eieoAnMsqE2Sq6HAOL9+Q3Ieur0f/4pE8weHJqN
        351TBdzmEWF1R
X-Received: by 2002:a17:906:c259:b0:7ae:df97:a033 with SMTP id bl25-20020a170906c25900b007aedf97a033mr14489512ejb.344.1668592113191;
        Wed, 16 Nov 2022 01:48:33 -0800 (PST)
X-Google-Smtp-Source: AA0mqf46f5R98rWOiuVMfxT5H9JqDg0AMWcLplaALtHZKqoGKNlX4UvAtiJsthbmVSFbclKGQv1LDg==
X-Received: by 2002:a17:906:c259:b0:7ae:df97:a033 with SMTP id bl25-20020a170906c25900b007aedf97a033mr14489439ejb.344.1668592111657;
        Wed, 16 Nov 2022 01:48:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id t23-20020aa7d717000000b0046800749670sm3369927edq.53.2022.11.16.01.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 01:48:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 2F5407A6DDA; Wed, 16 Nov 2022 10:48:30 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>,
        Stanislav Fomichev <sdf@google.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next 06/11] xdp: Carry over xdp
 metadata into skb context
In-Reply-To: <fd21dfd5-f458-dfba-594d-3aafd6a4648a@linux.dev>
References: <20221115030210.3159213-1-sdf@google.com>
 <20221115030210.3159213-7-sdf@google.com>
 <fd21dfd5-f458-dfba-594d-3aafd6a4648a@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 16 Nov 2022 10:48:30 +0100
Message-ID: <87bkp7jklt.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Martin KaFai Lau <martin.lau@linux.dev> writes:

> On 11/14/22 7:02 PM, Stanislav Fomichev wrote:
>> Implement new bpf_xdp_metadata_export_to_skb kfunc which
>> prepares compatible xdp metadata for kernel consumption.
>> This kfunc should be called prior to bpf_redirect
>> or when XDP_PASS'ing the frame into the kernel (note, the drivers
>> have to be updated to enable consuming XDP_PASS'ed metadata).
>> 
>> veth driver is amended to consume this metadata when converting to skb.
>> 
>> Internally, XDP_FLAGS_HAS_SKB_METADATA flag is used to indicate
>> whether the frame has skb metadata. The metadata is currently
>> stored prior to xdp->data_meta. bpf_xdp_adjust_meta refuses
>> to work after a call to bpf_xdp_metadata_export_to_skb (can lift
>> this requirement later on if needed, we'd have to memmove
>> xdp_skb_metadata).
>
> It is ok to refuse bpf_xdp_adjust_meta() after bpf_xdp_metadata_export_to_skb() 
> for now.  However, it will also need to refuse bpf_xdp_adjust_head().

I'm also OK with deferring this, although I'm wondering if it isn't just
as easy to just add the memmove() straight away? :)

-Toke


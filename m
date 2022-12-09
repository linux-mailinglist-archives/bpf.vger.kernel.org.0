Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16894647A7F
	for <lists+bpf@lfdr.de>; Fri,  9 Dec 2022 01:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiLIAIt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Dec 2022 19:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLIAIp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 8 Dec 2022 19:08:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777C112775
        for <bpf@vger.kernel.org>; Thu,  8 Dec 2022 16:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670544466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UnV9sHMygGeqceDB6oqgI6Lx3Hl0PuFE6k1V3XoJZrg=;
        b=A5vMeksoSRg390qNtjeuv5kOk+uBTca7mxRXxQmxlna1hYbK+XgvWDQu7umXYHiVyj6VFe
        9Ko4vvgPPranqSuldoe9Wi66NUIHV+VN7psemL486afJ5O9J7i/0mXJrovdlgGIg4Wrjrw
        1TQbmGd5o1H7Jmw/TsQncBtwt7vfZaA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-292-K8hnRG16NpKIfJK_w0NkyA-1; Thu, 08 Dec 2022 19:07:45 -0500
X-MC-Unique: K8hnRG16NpKIfJK_w0NkyA-1
Received: by mail-ed1-f72.google.com with SMTP id z3-20020a056402274300b0046b14f99390so394267edd.9
        for <bpf@vger.kernel.org>; Thu, 08 Dec 2022 16:07:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UnV9sHMygGeqceDB6oqgI6Lx3Hl0PuFE6k1V3XoJZrg=;
        b=0E2/Gk03i9wZxxATCu5N+WXmt78lEi1xXBSJ5GUYonAswEsvIlqxe9Fm3uqBHWKyjL
         ESVcHlfg0X4MpICk0JAADPQZRgbieLJg2I22XOaDULqFRKouj0Ov8On9+wNrwwqgj/xI
         1EE01oM0EuC7uVF8C9fg2WTwh8kgO7qf/27Oa/U3GFhj11jMo9H6O0giYaxgqgOnhU0M
         TAkBPZ2tRaQpHT2IqM0f/pX3hGDAdCGKEOl/GZn6kH3B0SDAOTyRdFkvVB0rlI+9rwV7
         hI8BanYtxciBr+SdibMXlVGVg8HHJDpWD51K2keEyHUTZ+XTG4BD4vI01ly0+IlRNATf
         KcKw==
X-Gm-Message-State: ANoB5pkqu2rxzN5oA9wEgyHpO5zaKvWwxNXH0UPW95ra4U8z3fXTxSls
        0v1YM3eaVRMdSjZKFe4I56kETAWMMEcAybfzCF4OQUqNIK6ysg/otdtd1ek7CmNDHcgy9+5cSO0
        d6Nqib2alNg8Y
X-Received: by 2002:a17:907:8a22:b0:7af:16b5:9af8 with SMTP id sc34-20020a1709078a2200b007af16b59af8mr4472671ejc.33.1670544461802;
        Thu, 08 Dec 2022 16:07:41 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4jxNWVpUDFqe+Y4asR9M7ckORo70cpv13tgtmDSLBwLKzO+sRaQhDNDbBSqyQ9hON3IMdxMQ==
X-Received: by 2002:a17:907:8a22:b0:7af:16b5:9af8 with SMTP id sc34-20020a1709078a2200b007af16b59af8mr4472566ejc.33.1670544459873;
        Thu, 08 Dec 2022 16:07:39 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k2-20020a170906680200b0077077c62cadsm10135739ejr.31.2022.12.08.16.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 16:07:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A80B782E9C7; Fri,  9 Dec 2022 01:07:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Subject: Re: [xdp-hints] Re: [PATCH bpf-next v3 03/12] bpf: XDP metadata RX
 kfuncs
In-Reply-To: <CAKH8qBvgkTXFEhd9hOa+SFtqKAXuD=WM_h1TZYdQA0d70_drEA@mail.gmail.com>
References: <20221206024554.3826186-1-sdf@google.com>
 <20221206024554.3826186-4-sdf@google.com> <878rjhldv0.fsf@toke.dk>
 <CAKH8qBvgkTXFEhd9hOa+SFtqKAXuD=WM_h1TZYdQA0d70_drEA@mail.gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 09 Dec 2022 01:07:37 +0100
Message-ID: <87zgbxjv7a.fsf@toke.dk>
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

Stanislav Fomichev <sdf@google.com> writes:

>> Another UX thing I ran into is that libbpf will bail out if it can't
>> find the kfunc in the kernel vmlinux, even if the code calling the
>> function is behind an always-false if statement (which would be
>> eliminated as dead code from the verifier). This makes it a bit hard to
>> conditionally use them. Should libbpf just allow the load without
>> performing the relocation (and let the verifier worry about it), or
>> should we have a bpf_core_kfunc_exists() macro to use for checking?
>> Maybe both?
>
> I'm not sure how libbpf can allow the load without performing the
> relocation; maybe I'm missing something.
> IIUC, libbpf uses the kfunc name (from the relocation?) and replaces
> it with the kfunc id, right?

Yeah, so if it can't find the kfunc in vmlinux, just write an id of 0.
This will trip the check at the top of fixup_kfunc_call() in the
verifier, but if the code is hidden behind an always-false branch (an
rodata variable set to zero, say) the instructions should get eliminated
before they reach that point. That way you can at least turn it off at
runtime (after having done some kind of feature detection) without
having to compile it out of your program entirely.

> Having bpf_core_kfunc_exists would help, but this probably needs
> compiler work first to preserve some of the kfunc traces in vmlinux.h?

I am not sure how the existing macros work, TBH. Hopefully someone else
can chime in :)

-Toke


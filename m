Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC82560270
	for <lists+bpf@lfdr.de>; Wed, 29 Jun 2022 16:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiF2OVA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Jun 2022 10:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiF2OU7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Jun 2022 10:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF3E21B7AD
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 07:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656512457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FiYmpBBjlfIbeiZDsnGGJUZmzd2clNYiuFHxeXQgGzc=;
        b=HYoz9wd9e5mZSE8w0+DDuOpKZ1VrsF4u7aEKt+HezNTnnLbuwa15Olukb3Shqct72ccmAq
        o81cjiJph/h40Y4T5BbzXPXvaskYQFUWhuAYYl2tL1YyB2AtchOv4Dt2wychGor0DP9nsT
        XJwuPJkZzlotnH0R22iNB+xapsVH7/k=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-471-QdBZfZTZOGSyccTo2sfEng-1; Wed, 29 Jun 2022 10:20:49 -0400
X-MC-Unique: QdBZfZTZOGSyccTo2sfEng-1
Received: by mail-ed1-f70.google.com with SMTP id i9-20020a05640242c900b004373cd1c4d5so11210133edc.2
        for <bpf@vger.kernel.org>; Wed, 29 Jun 2022 07:20:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=FiYmpBBjlfIbeiZDsnGGJUZmzd2clNYiuFHxeXQgGzc=;
        b=tn1RXHIFQd5/4lY0Vnunm209APA2hpE0vOzYssFTDkepaUXo48F7qleUFbYSlI3Agb
         IStOfoG0jrDlXj0S7lKy5W3XA/d/YCROAqtt8Q4SJotjYntAtY27VkvHbbPIyqI/eA1h
         XWiFNMta4BKaA4v7lhOfU+wXIU0p3Yn7NQdNtSfzRubqLRa8fI4wDwOYC8h/wua7jlKR
         /5aDcPK2v17tDmCHyr1bKWfrinVu3EmpczYcNUqVwkIX6KW5Jk4kZs1GIKA7iqCFT6pd
         0hdg4f8VKvOiiZ47lCajfEripjjiDAyDy7SJNwXQ+qOV8ZaJiGQ5S/RI/JSykd2HzA5R
         WLoQ==
X-Gm-Message-State: AJIora80Sy5uhw3z6c3TyIgcGPp/8KiiFpaW/Zh6Aqsrtd1EQ6fakPYb
        dyKZxsTa4PgpF3AWy/S6teiMh3dOlSF+fVtnC7cLlBQdXBYiib2iszvEneL4c1F9DIq5pNVUNZk
        Y2b4xqWk2mIJD
X-Received: by 2002:a17:906:149b:b0:726:2968:e32a with SMTP id x27-20020a170906149b00b007262968e32amr3608540ejc.71.1656512446476;
        Wed, 29 Jun 2022 07:20:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u+aP3pQSccdfNXYWYB8kCCDBlEwDGDLuhva5jc+VbGERRJ2DQ0PTjF2LI9MvNSsCpmK+SFLQ==
X-Received: by 2002:a17:906:149b:b0:726:2968:e32a with SMTP id x27-20020a170906149b00b007262968e32amr3608478ejc.71.1656512445656;
        Wed, 29 Jun 2022 07:20:45 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id g6-20020a1709064e4600b007121b22b376sm7737010ejw.105.2022.06.29.07.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 07:20:45 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 8CA16477063; Wed, 29 Jun 2022 16:20:44 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <brouer@redhat.com>, bpf@vger.kernel.org
Cc:     xdp-hints@xdp-project.net
Subject: Re: [xdp-hints] [PATCH RFC bpf-next 5/9] xdp: controlling XDP-hints
 from BPF-prog via helper
In-Reply-To: <165643385885.449467.3259561784742405947.stgit@firesoul>
References: <165643378969.449467.13237011812569188299.stgit@firesoul>
 <165643385885.449467.3259561784742405947.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 29 Jun 2022 16:20:44 +0200
Message-ID: <87fsjna6v7.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Jesper Dangaard Brouer <brouer@redhat.com> writes:

> XDP BPF-prog's need a way to interact with the XDP-hints. This patch
> introduces a BPF-helper function, that allow XDP BPF-prog's to interact
> with the XDP-hints.
>
> BPF-prog can query if any XDP-hints have been setup and if this is
> compatible with the xdp_hints_common struct. If XDP-hints are available
> the BPF "origin" is returned (see enum xdp_hints_btf_origin) as BTF can
> come from different sources or origins e.g. vmlinux, module or local.

I'm not sure I quite understand what this origin is supposed to be good
for? What is a BPF (or AF_XDP) program supposed to do with the
information "this XDP hints struct came from a module?" without knowing
which module that was? Ultimately, the origin is useful for a consumer
to check that the metadata is in the format that it's expecting it to be
in (so it can just load the data from the appropriate offsets). But to
answer this, we really need a unique identifier; so I think the approach
in Alexander's series of encoding the ID of the BTF structure itself
into the next 32 bits is better? That way we'll have a unique "pointer"
to the actual struct that's in the metadata area and can act on this.

> RFC/TODO: Improve patch: Can verifier validate provided BTF on "update"
> and detect if compatible with common struct???

If we have the unique ID as mentioned above, I think the kernel probably
could resolve this automatically: whenever a module is loaded, the
kernel could walk the BTF information from that module an simply inspect
all the metadata structs and see if they contain the embedded
xdp_hints_common struct. The IDs of any metadata structs that do contain
the common struct can then be kept in a central lookup table and the
consumption code can then simply compare the BTF ID to this table when
building an SKB?

As for the validation on the BPF side:n

> +	if (flags & HINTS_BTF_UPDATE) {
> +		is_compat_common = !!(flags & HINTS_BTF_COMPAT_COMMON);
> +	/* TODO: Can kernel validate if hints are BTF compat with common? */
> +	/* TODO: Could BPF prog provide BTF as ARG_PTR_TO_BTF_ID to prove compat_common ? */

If we use the "global ID + lookup table" approach above, we don't really
need to validate anything here: if the program says it's writing
metadata with a format given by a specific ID, that implies
compatibility (or not) as given by the ID. We could sanity-check the
metadata area size, but the consumption code has to do that anyway, so
I'm not sure it's worth the runtime overhead to have an additional check
here?

As for safety of the metadata content itself, I don't really think we
can do anything to guarantee this: in any case the BPF program can pass
a valid BTF ID and still write garbage values into the actual fields, so
the consumption code has to do enough validation that this won't crash
the kernel anyway. But this is no different from the packet data itself:
XDP is basically in a position to be a MITM attacker of the network
stack itself, which is why loading XDP programs is a privileged
operation...

-Toke


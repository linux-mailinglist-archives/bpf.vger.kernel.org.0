Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C883964DA01
	for <lists+bpf@lfdr.de>; Thu, 15 Dec 2022 12:04:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbiLOLEi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Dec 2022 06:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLOLEh (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 15 Dec 2022 06:04:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440FFBB7
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 03:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1671102228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xfgW1cNDY6SFXcm9NSi+GCdWYB7FfulFe9E2Yz7AbyY=;
        b=BydhQxNSTwvpP0dhES8xa+ac6Y47TG+55GHi6/lYnSRmTtbOVQejfyoZovQ3DXtgRGijGA
        zjcz6ohrcFLiNnkvRQPhi/4zvn27tyQZUzvxebChGkD7fqazCBDeq2iw/O6nR5zYkLeeWy
        z+KJoLjJBBNV59G7WpXeGvRzB5MwVA4=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-DK7rClgZNbyXS9IeH3VvQw-1; Thu, 15 Dec 2022 06:03:47 -0500
X-MC-Unique: DK7rClgZNbyXS9IeH3VvQw-1
Received: by mail-ej1-f72.google.com with SMTP id sg39-20020a170907a42700b007c19b10a747so4152410ejc.11
        for <bpf@vger.kernel.org>; Thu, 15 Dec 2022 03:03:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfgW1cNDY6SFXcm9NSi+GCdWYB7FfulFe9E2Yz7AbyY=;
        b=D/1A9/PijacN/6gNB+QJI+8wLQ3hkr66KGW4d3OHee1vwlgz3hkHrzDWxIGAQW4z82
         2R7KDarXzjClXLVFGw3lq3PylhfiwpDLVboSZc8mWoi8hCXMXVdbvM1IWEADAj1t+axb
         foIOxHLgjc9BJqlp7UyMVHpMV7xIBZc+KRYmRgjAVIflLJA+xIZR9ynLQXtkXDHSDMfH
         990YM0nHhPr+3wV+0PoQH+GNU79fDYgHMT6T5V8//kq9ZePDTfeyQqZFXTmZhJ7F/fpj
         OL8dnfIx4TI8svBfYJaU2Gi9KGsVcXSG2p137EOOG7oz9csKRWwUCRS4DJ3c3efNuzUQ
         dXcw==
X-Gm-Message-State: ANoB5pm+jKz4Bpp9/S2Ehq/pmpRSwKq69eFGOkK5JN6AbObGnMkje3Dj
        syscU4aVmtchPrfImg8BUPuIUnReHQNOaJ+CpFISJLc2kNCR7GCkqU7POzfsf16yqwb5koA9ZM4
        dW48U9sP2F4+l
X-Received: by 2002:a05:6402:12c9:b0:46c:55ef:8d50 with SMTP id k9-20020a05640212c900b0046c55ef8d50mr23870950edx.24.1671102225351;
        Thu, 15 Dec 2022 03:03:45 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6/wAtrfeHFoioZT+YaU/Hn6/x4tI/49NpIvpo0KAcrHK+TqcCDh4Hrm91P4dTQVoyozWs7VA==
X-Received: by 2002:a05:6402:12c9:b0:46c:55ef:8d50 with SMTP id k9-20020a05640212c900b0046c55ef8d50mr23870873edx.24.1671102223550;
        Thu, 15 Dec 2022 03:03:43 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id y15-20020a056402134f00b0046b531fcf9fsm7339968edw.59.2022.12.15.03.03.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 03:03:43 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 6C25F82F7A8; Thu, 15 Dec 2022 12:03:42 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH bpf v5 1/2] bpf: Resolve fext program type when checking
 map compatibility
In-Reply-To: <f06b0219-db2a-8b01-cda2-75f828932d93@linux.dev>
References: <20221214230254.790066-1-toke@redhat.com>
 <f06b0219-db2a-8b01-cda2-75f828932d93@linux.dev>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Thu, 15 Dec 2022 12:03:42 +0100
Message-ID: <87o7s5dj3l.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

> On 12/14/22 3:02 PM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> This requires constifying the parameter of
>> resolve_prog_type() to avoid a compiler warning from the new call site.
>
> Applied with this part removed from the commit message.  This change is n=
ot in=20
> this patch.  The const had already been added a while back.

Ah, right; it was in an earlier version (because I was making the change
in the bpf tree, not bpf-next), and I didn't notice it disappeared when
I rebased. Thanks for fixing! :)

-Toke


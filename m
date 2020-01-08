Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E737133F3C
	for <lists+bpf@lfdr.de>; Wed,  8 Jan 2020 11:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgAHKZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Jan 2020 05:25:07 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:21494 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727091AbgAHKZH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 8 Jan 2020 05:25:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578479106;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oC4Q93wHOEu7szjQ4WODCdmXFpTYePyogruOHiv2Xcs=;
        b=UJeTonIvraOrlH28ZLLGOxIOEvTdI0IgiD7AAeUQK7RZ+213U7GwG+NEK2bVQP+3iYnNAf
        yOS7LRAuBPPUVjIjmy2qy9ZhxW9HIM/SuP/dzi1G8+yTN0vqG4vYQ6InOnRN4cv4NJ6wQW
        WVsfv3sD/C4Lj/4egcW76HTBvcoWwOc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-Sz0SkUoDOyO9d20MeuJFHA-1; Wed, 08 Jan 2020 05:25:05 -0500
X-MC-Unique: Sz0SkUoDOyO9d20MeuJFHA-1
Received: by mail-wm1-f69.google.com with SMTP id l11so3878723wmi.0
        for <bpf@vger.kernel.org>; Wed, 08 Jan 2020 02:25:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oC4Q93wHOEu7szjQ4WODCdmXFpTYePyogruOHiv2Xcs=;
        b=jrE3gGmC+/JqVCW6+I1dD5Fzjqp6/IGeXCiOma3P3b/SCHdYcmQDQIt5RXTGHXL1nJ
         hOmcgjOs6CiHNfmbAB/K9Zi8DUaWcveJh/p/BvHYK/4TLBttZM55vykTCHwK8IbMK7Ss
         XvzZPTOlJBtYZR4JcVRdZ/9zTqpI9liIkzF1btcdO9i0YSQASEOJU5ijH7fPzfig9X8j
         NO2mlAerclI1FmBaK3bqoPKw1ljwUlfiO7cxTYwCK250cXBaesaKXEcAkZiqvBwImX7c
         DUhNKOU0NWmKqa/IYgk8Ueg+iz1LhNwvnH/dKn5Zxq8NE18QLFS2zIBqUHzgUj351OeQ
         YP4g==
X-Gm-Message-State: APjAAAX2pZ1/Tc9wpCgcIaEf2hjwjouVLxaZwLdJUNTJFsJsRaCrrZbJ
        eUeB/PuYl79wY0iDWgewTmc+fZ4Ql7Q9X1T5bIsRbpg7meccjJtbBL4xMEEIVkRykZ926COZe2C
        E3PylLRq0m7gK
X-Received: by 2002:adf:f10a:: with SMTP id r10mr3662585wro.202.1578479104275;
        Wed, 08 Jan 2020 02:25:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxbi2223EDy0LSP6/0QUx/0GdgkbCd8CoIkFLdGiZlYd4W8/pZSDFK3EA82d21AAEGAoWVABA==
X-Received: by 2002:adf:f10a:: with SMTP id r10mr3662569wro.202.1578479104111;
        Wed, 08 Jan 2020 02:25:04 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id v83sm3253888wmg.16.2020.01.08.02.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 02:25:03 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0D7D3180ADD; Wed,  8 Jan 2020 11:25:03 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>, davem@davemloft.net
Cc:     daniel@iogearbox.net, netdev@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH bpf-next 2/6] libbpf: Collect static vs global info about functions
In-Reply-To: <20200108072538.3359838-3-ast@kernel.org>
References: <20200108072538.3359838-1-ast@kernel.org> <20200108072538.3359838-3-ast@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Wed, 08 Jan 2020 11:25:02 +0100
Message-ID: <871rsai6td.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Alexei Starovoitov <ast@kernel.org> writes:

> Collect static vs global information about BPF functions from ELF file and
> improve BTF with this additional info if llvm is too old and doesn't emit it on
> its own.

Has the support for this actually landed in LLVM yet? I tried grep'ing
in the commit log and couldn't find anything...

[...]
> @@ -313,6 +321,7 @@ struct bpf_object {
>  	bool loaded;
>  	bool has_pseudo_calls;
>  	bool relaxed_core_relocs;
> +	bool llvm_emits_func_linkage;

Nit: s/llvm/compiler/? Presumably GCC will also support this at some
point?

-Toke


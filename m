Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBF58456F49
	for <lists+bpf@lfdr.de>; Fri, 19 Nov 2021 14:03:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbhKSNGp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 19 Nov 2021 08:06:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55018 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235255AbhKSNGo (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 19 Nov 2021 08:06:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637327022;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hKfzGk0Wpd8IGC/prDVcUoPiImNh9tLcC0HmBj731Mc=;
        b=WwRaXgbqU78bWO6pwcPZbhOOytBcuv2QP1e817JV6IimeGoKeHGP+uUOfwsHWPMPVP+nEp
        wC5oG0yP102S7exM7XHCjeg9LT4QAbOThm52mdD4732ALg+fjBv9QvluzFOVSEgJiMDFGS
        sr/EVOLWev5GQOSk3SCikoLKQVmZl+Q=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-276-35riKQkLPJO-tpS_w6WWfg-1; Fri, 19 Nov 2021 08:03:41 -0500
X-MC-Unique: 35riKQkLPJO-tpS_w6WWfg-1
Received: by mail-ed1-f69.google.com with SMTP id v9-20020a50d849000000b003dcb31eabaaso8362848edj.13
        for <bpf@vger.kernel.org>; Fri, 19 Nov 2021 05:03:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=hKfzGk0Wpd8IGC/prDVcUoPiImNh9tLcC0HmBj731Mc=;
        b=1ItD3MlcRPLrgzXWLqoDmd7Gq8W0ERm2dTHOt3nWWFfZpq0YRSvVfGNJ6eltinemXh
         KH6D4ohbd+DoxgA02jCS9WfmwwLcmtvIm0lki2EIxUDB51ih/egxzGFDAAfmsy8EpkwV
         Zrn8H4cs7i2mm4qwT+eTG39b12z1v1iQdQaIw65MgMLRpA1WFy5yLTrNeGt2narjpV5r
         6RH/caEZ+oOnwAH9Fm11kbKNGQzPEEXX1p1bU4ov2Mo+575QSSn6TZemPnvdnkMkgwT4
         OhH5aCjIo1DygMDoTLY2fX6ZbTOIJHjluMicwqJ5oKnpfipIdnsSC6ZCtMoTvLjNRv7N
         +UXg==
X-Gm-Message-State: AOAM530dOQlj7ZXqR2GUPGLsjPYHajb8Q4wqWc6LhyHG5HkbFeyIr67g
        VRAEuQH6L260pHVEvGzP4AJw3+ORCDg00sFyppJUBYWU3eK8FivRna+3JcZVadarE8E3EXMR0U+
        U5oQty50rpUrZ
X-Received: by 2002:a05:6402:34d6:: with SMTP id w22mr24389967edc.35.1637327019609;
        Fri, 19 Nov 2021 05:03:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx0iYtHfCnciVMnXitwgUqkXXZdqqWWg/E2uIeEkNqY5pWCuyejuk1lAeev+8CNOUCiai6nhA==
X-Received: by 2002:a05:6402:34d6:: with SMTP id w22mr24389826edc.35.1637327018826;
        Fri, 19 Nov 2021 05:03:38 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id dz18sm238310edb.74.2021.11.19.05.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 05:03:38 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 87A81180270; Fri, 19 Nov 2021 14:03:37 +0100 (CET)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Christoph Hellwig <hch@lst.de>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/2] bpf, doc: split general purpose eBPF documentation
 out of filter.rst
In-Reply-To: <20211119061642.GB15129@lst.de>
References: <20211115130715.121395-1-hch@lst.de>
 <20211115130715.121395-3-hch@lst.de>
 <20211118005613.g4sqaq2ucgykqk2m@ast-mbp> <20211119061642.GB15129@lst.de>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 19 Nov 2021 14:03:37 +0100
Message-ID: <877dd4e1qu.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

>> In terms of followups and cleanup... please share what you have in mind.
>
> The prime issue I'd like to look in is to replace all the references
> to classic BPF and instead make the document standadlone.

Yes, please, this would be awesome! :)

-Toke


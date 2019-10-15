Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1023D7C28
	for <lists+bpf@lfdr.de>; Tue, 15 Oct 2019 18:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbfJOQm0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Tue, 15 Oct 2019 12:42:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51776 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728557AbfJOQm0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 15 Oct 2019 12:42:26 -0400
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com [209.85.167.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E4B434FCD6
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 16:42:25 +0000 (UTC)
Received: by mail-lf1-f71.google.com with SMTP id d11so600788lfj.3
        for <bpf@vger.kernel.org>; Tue, 15 Oct 2019 09:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=FW3P7qV7p2rcw6iaDWO0SDSSmY0ORDZ86N4a3ia/7xs=;
        b=X5JwH1hSalIvi6k9Lj1piZsBw6l7Ej9m6Lxsy8AZyFttVKD+p+Y14LuOSTnv30SST2
         2I8qt54+e2EYBzSyLv5SabTB2x/uCyZkhug7bLa236JplFN7cZIyb+bxFjTPrT3KtA2z
         kJv0teAk7CDAk6Veiy8B5rdqO2LN+GmkqHRa+XYuHBISvEztfm1mP4mnmCknBS0v0r9C
         xf+bA7JzXgydjnDcQVOI9x5Qme1Ob+oS5QTo6D8DhI0F0zGOLN3PhxazqNyuO1iMvE7l
         29Gnm5TePfdn1a85b5tWqM6QZNteuX6psZuqTL2qoMIgRk3s95R5LQGS/7Fsm6h9RUD0
         JwZg==
X-Gm-Message-State: APjAAAWleD+IIsivv+VSBEO/gARBIpPl/r2k9v35SDVifJjV0nJGcTrt
        FAFASfxmlAvz4EpiCgpaqKpS9WLRSk/syVoitXJn4nQ5AjcUgZk6XK4GpIM4PZBqtixQSdGKxui
        tseXZWU2Zpyzv
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr16268627ljj.27.1571157744328;
        Tue, 15 Oct 2019 09:42:24 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzw9zhfluDjbM4/GOcbS7fCTOHWz72Bp1JeZjuflcmfXWtQxMPDMPT0VPH1oxi91H0pl1vK8g==
X-Received: by 2002:a2e:86cd:: with SMTP id n13mr16268607ljj.27.1571157744049;
        Tue, 15 Oct 2019 09:42:24 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a00:7660:6da:443::2])
        by smtp.gmail.com with ESMTPSA id t24sm5114934ljc.23.2019.10.15.09.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 09:42:23 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 0A5451803A8; Tue, 15 Oct 2019 18:42:22 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Edward Cree <ecree@solarflare.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Marek Majkowski <marek@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        Alan Maguire <alan.maguire@oracle.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v3 1/5] bpf: Support chain calling multiple BPF programs after each other
In-Reply-To: <f9d5f717-51fe-7d03-6348-dbaf0b9db434@solarflare.com>
References: <157046883502.2092443.146052429591277809.stgit@alrua-x1> <157046883614.2092443.9861796174814370924.stgit@alrua-x1> <20191007204234.p2bh6sul2uakpmnp@ast-mbp.dhcp.thefacebook.com> <87sgo3lkx9.fsf@toke.dk> <20191009015117.pldowv6n3k5p3ghr@ast-mbp.dhcp.thefacebook.com> <87o8yqjqg0.fsf@toke.dk> <20191010044156.2hno4sszysu3c35g@ast-mbp.dhcp.thefacebook.com> <87v9srijxa.fsf@toke.dk> <5da4ab712043c_25f42addb7c085b83b@john-XPS-13-9370.notmuch> <87eezfi2og.fsf@toke.dk> <f9d5f717-51fe-7d03-6348-dbaf0b9db434@solarflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Tue, 15 Oct 2019 18:42:21 +0200
Message-ID: <87r23egdua.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Edward Cree <ecree@solarflare.com> writes:

> On 14/10/2019 19:48, Toke Høiland-Jørgensen wrote:
>> So that will end up with a single monolithic BPF program being loaded
>> (from the kernel PoV), right? That won't do; we want to be able to go
>> back to the component programs, and manipulate them as separate kernel
>> objects.
> Why's that? (Since it also applies to the static-linking PoC I'm
> putting together.) What do you gain by having the components be
> kernel-visible?

Because then userspace will have to keep state to be able to answer
questions like "show me the list of programs that are currently loaded
(and their call chain)", or do operations like "insert this program into
the call chain at position X".

We already keep all this state in the kernel, so replicating it all in
userspace means both a lot of extra work to implement that
functionality, and having to deal with the inevitable fallout when the
userspace and kernel space state get out of sync...

-Toke

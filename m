Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05E42F20A
	for <lists+bpf@lfdr.de>; Fri, 15 Oct 2021 15:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239360AbhJONYn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 15 Oct 2021 09:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55715 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239351AbhJONYm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 15 Oct 2021 09:24:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634304155;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6i4ZlcpI65G0vVAJgnz1cFjngGSuB+RC98zfnoRpQag=;
        b=PvaldnlvWDq8CTi3qnZlr8sIyFUgJxR0s1G9zKffRfT0N3LO4kTt2YmrtiQbNlizB7d9fx
        L0yb1G0FBckH+OFWRsJR2C3zvqAPcBlT8uvviiG/9lE+d7rh81qpOa+66Yyf9P/ix+LmKl
        y5Urr5GfpNQs3RZgSyiGraPfa0h19Rw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-451-enE4xlzkOZ2K2SeP-A-i5A-1; Fri, 15 Oct 2021 09:22:34 -0400
X-MC-Unique: enE4xlzkOZ2K2SeP-A-i5A-1
Received: by mail-ed1-f69.google.com with SMTP id c30-20020a50f61e000000b003daf3955d5aso8225977edn.4
        for <bpf@vger.kernel.org>; Fri, 15 Oct 2021 06:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=6i4ZlcpI65G0vVAJgnz1cFjngGSuB+RC98zfnoRpQag=;
        b=hSh9KJkUBFVx4++oLnzYjEvJza0qup7i/J7Po5/usJ/TP+2ozgy0RBdV21a2KbslRQ
         27+yX2aNd1MXAdMMy7CjDtq1uJ8rL1ZPKSzjrLZzQYhMEyUhda2yaqx8HsQBV6wRPxN3
         oD7GTMkxZgHe52u7oix/WNlekITRLyhXmwtVKcrydtJA7MfEfx8+ZVf0g/TlyeKCwdDp
         l6bmPXV5ciSCt40DZN775qV49RE69nl7biKLCXn2qdTqXkn4N4eeWRw5EhJry5x0xoDH
         6QMzZAn6gPpJk1VInZyGYU8NgbXB9y32bVWkSjyr2SQCN/TSybQefAO/bKMSJn2jgIS1
         1PhA==
X-Gm-Message-State: AOAM532vA2dQgTjr1WlayEk/TZlkLPUo+0YR1Btn2uyoxZF++iZ53f6H
        ICY9NFFNeZPDQJluflxzbkBJzd6XoHUgI3AIvzmNAE4F/m2dlnybQaiZvwTXFRI+69SD4LT2p4P
        yFZdKdpJTwFNc
X-Received: by 2002:a17:906:a158:: with SMTP id bu24mr6440726ejb.356.1634304152649;
        Fri, 15 Oct 2021 06:22:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf7iElNP6x1ZTn76DCAvYzuu9ypXwRBvtux0Y3zYiqJL2i3G/wNYIAuJgTIg0LlcEnuT3W1g==
X-Received: by 2002:a17:906:a158:: with SMTP id bu24mr6440696ejb.356.1634304152394;
        Fri, 15 Oct 2021 06:22:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ck9sm4210345ejb.56.2021.10.15.06.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 06:22:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 5A5E518025F; Fri, 15 Oct 2021 15:22:31 +0200 (CEST)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     lorenzo.bianconi@redhat.com, davem@davemloft.net, kuba@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, shayagr@amazon.com,
        john.fastabend@gmail.com, dsahern@kernel.org, brouer@redhat.com,
        echaudro@redhat.com, jasowang@redhat.com,
        alexander.duyck@gmail.com, saeed@kernel.org,
        maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
        tirthendu.sarkar@intel.com
Subject: Re: [PATCH v16 bpf-next 09/20] bpf: introduce BPF_F_XDP_MB flag in
 prog_flags loading the ebpf program
In-Reply-To: <0a48666cfb23d1ceef8d529506e7ad2da90079de.1634301224.git.lorenzo@kernel.org>
References: <cover.1634301224.git.lorenzo@kernel.org>
 <0a48666cfb23d1ceef8d529506e7ad2da90079de.1634301224.git.lorenzo@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date:   Fri, 15 Oct 2021 15:22:31 +0200
Message-ID: <87y26uzalk.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Lorenzo Bianconi <lorenzo@kernel.org> writes:

> Introduce BPF_F_XDP_MB and the related field in bpf_prog_aux in order to
> notify the driver the loaded program support xdp multi-buffer.

We should also add some restrictions in the BPF core. In particular,
tail call, cpumap and devmap maps should not be able to mix multi-buf
and non-multibuf programs.

-Toke


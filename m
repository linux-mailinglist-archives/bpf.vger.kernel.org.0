Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C51F641C2E1
	for <lists+bpf@lfdr.de>; Wed, 29 Sep 2021 12:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243839AbhI2Knr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 29 Sep 2021 06:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243413AbhI2Knq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 29 Sep 2021 06:43:46 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7080C06174E
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 03:42:05 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id b20so8891230lfv.3
        for <bpf@vger.kernel.org>; Wed, 29 Sep 2021 03:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l4erC+Dux4RZpiXMM/8/AcTUcBimHibMLQAzv6DQU+o=;
        b=pWTyYkAmJjxtOkLL51V9mg/PqbDP0E4u7jg0yms1QQGQA1zh82E1sDNFiENspqFOQd
         ZOviufEk1Eh17LabV0MlzjC5UT2eIfAMOnKJ5WIbjIQa0QUzvKYF+i8D3bsiryE0TS1j
         gtILkjxA6L8rkFT0/QfyG2ddElo77KHom9BXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l4erC+Dux4RZpiXMM/8/AcTUcBimHibMLQAzv6DQU+o=;
        b=EohK7E/aTkzxP6T6suB3viQ+p1j39Ezx6gUKNJnAHZh2gicqVSXBr7gSOOnYlXRwdw
         e4/+VJl1W2nI3wo4EXUNDYaWgtB/hIyCKkZ9eyUrLGeXnKk8XQeQ/wMqBWKRx6YHTwcQ
         eaaDmqRQT8zKC4HxO3of1othZjHpLIQPKZ27vw6maYhBMkqstuKpsLSdkNtoV3AsS0rV
         /nuM/etk3fcE/RylXq/Wh02jN2VU8uMSWofPX4ZK2zbY7zV2b7GXY97QqYVkowQoXDS4
         QBRmx+GDoVP7xqj21h34eNG5/BRcEFV+j4XxgjhVp60KjzAZfeftaf6Qs8ScdJ9jFMIg
         tMfQ==
X-Gm-Message-State: AOAM530yUxJWTETd9WJUtdczbDp9jU9+tDGJwj/lhjzXy4lMi7iCmiob
        Bt7/J+xi2qu2GcQegloWBZeeguhbJpUy/8ZychjtpQ==
X-Google-Smtp-Source: ABdhPJxNcgw9R6eeCfEocG9e8F8Aybsbx5fSHlscbgfa1bAlq6/YFqo30VRhN1YI39oEy1axhn5p0gr2v8Vo/6OzK4o=
X-Received: by 2002:a2e:8852:: with SMTP id z18mr5401934ljj.412.1632912123996;
 Wed, 29 Sep 2021 03:42:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631289870.git.lorenzo@kernel.org> <20210916095539.4696ae27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20210916095539.4696ae27@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Wed, 29 Sep 2021 11:41:53 +0100
Message-ID: <CACAyw9-8t8RpJgJUTd7u6bOLnJ1xQsgK7z37QrL9T1FUaJ7WNQ@mail.gmail.com>
Subject: Re: [PATCH v14 bpf-next 00/18] mvneta: introduce XDP multi-buffer support
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>, bpf <bpf@vger.kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, shayagr@amazon.com,
        John Fastabend <john.fastabend@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Eelco Chaudron <echaudro@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeed@kernel.org>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        "Karlsson, Magnus" <magnus.karlsson@intel.com>,
        tirthendu.sarkar@intel.com,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 16 Sept 2021 at 18:47, Jakub Kicinski <kuba@kernel.org> wrote:
>
> Won't applications end up building something like skb_header_pointer()
> based on bpf_xdp_adjust_data(), anyway? In which case why don't we
> provide them what they need?
>
> say:
>
> void *xdp_mb_pointer(struct xdp_buff *xdp_md, u32 flags,
>                      u32 offset, u32 len, void *stack_buf)
>
> flags and offset can be squashed into one u64 as needed. Helper returns
> pointer to packet data, either real one or stack_buf. Verifier has to
> be taught that the return value is NULL or a pointer which is safe with
> offsets up to @len.
>
> If the reason for access is write we'd also need:
>
> void *xdp_mb_pointer_flush(struct xdp_buff *xdp_md, u32 flags,
>                            u32 offset, u32 len, void *stack_buf)

Yes! This would be so much better than bpf_skb_load/store_bytes(),
especially if we can use it for both XDP and skb contexts as stated
elsewhere in this thread.

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com

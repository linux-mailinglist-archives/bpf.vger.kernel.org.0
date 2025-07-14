Return-Path: <bpf+bounces-63242-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8220B047C7
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 21:10:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD827AC3BF
	for <lists+bpf@lfdr.de>; Mon, 14 Jul 2025 19:08:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D82277C95;
	Mon, 14 Jul 2025 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykICPj1f"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC682E36F0
	for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 19:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752520206; cv=none; b=W03IccC7rv3fxomFDMRKQ8Ee57tge1pfm4tu1aWFe5ezqIYIdapcjofz4FksgeGj19LBROXiysPy8YULyA8kOg+rXyYDLFEW4pH0/cgTidtzEERGREKWHXSnIWyonFS5kshJSBgXWr94+PgahoOnYUm9Njz6vNOWdBgFpfL9y6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752520206; c=relaxed/simple;
	bh=Q4x6iItTBB3tI7sU5svPSPLqiIoOz48SRpYj7oLMZjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W7SqoTIAqmcEYOfoGMkELdAz9xVOvONoIhiJaR66Wej8OJn/wvQXL/OrceMltwAhBYgw5lfqVjwW1GcMxi2ay1Q6vXY4gN31zy+d/41j0RW7aty7j+P+pVzsbwuuq29a3MXFTWBBQKK8fHlTH1bvpZZXkPM2+ZC4IMUH4FWHxB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykICPj1f; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-23dd9ae5aacso29495ad.1
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 12:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1752520204; x=1753125004; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ebLXrXBkN/FXUY5+SvTmd1RPkblTK+L4FX/VBIrHA8=;
        b=ykICPj1fbOe4e/1rv0dlgSOqz5rOxyGKCa04u+74nOI62JvDtS0JESVABLrpg5my9s
         0OR2ZJSj0glb8XWC898pFx9jtBY6hLAEelULrTgZXKoMz2hGDI5mSfeHqUu5VybYBqzG
         j7FkUKq/avVK7Mw5v4+gJKrkZ0rO+2+mKzSOL9b/pwUENoodVXIpPN7H4CkVtEZ4O3dB
         o8VeQRqleXCQ0oHA9ZmnmjCBgoyM6tVruzKdAQ/sU93EDJF680gWwpTRyppeEedsY3x0
         bEjmkw5fErTq5BbMD73vtrAdCycjuEMjEihxCF7NG3u66eciie0yvpOMlg9HcJrMTjM8
         4Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752520204; x=1753125004;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ebLXrXBkN/FXUY5+SvTmd1RPkblTK+L4FX/VBIrHA8=;
        b=Hc3k7ADsoFACZYFykqo7/aes47/8Ohhi+2SJ9wh16NQZHGEbr/I24RgCi5xeW8pkjb
         YdVoDmOAIdjJjs14ht8q3BbsRpL7aY1cqWyJ6m6NE8wW3z0v2xgvPc8RT3RwivsyZUSO
         ZqhqeRYVziZ3y7+pmkimj5anC2y/AvB1FXO1xQio+ATx8c35AksKkA/gtmokOnP3U7jq
         y9teYtf2OyLvrW09E/QNsyKwpRGwKecsiDD7Y+TToe/UBEYMEX6lBWgIV6H5w75076vi
         wCV6RL1w9vhU8L2cW/dqyflmnxVL3ANuaApXOzcVj3ZdMdHwi8fGy3e2zbsWrR9xZM4D
         n68w==
X-Forwarded-Encrypted: i=1; AJvYcCXTbRUiyu1scFlQcQUtAWlgZGe0WmC4KIMDetU17IFJI293kb5x2GQysxExk3SBfbkhDsE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJHFnh2n3nhgo5OEI2VHb8BuwrsQZ7xJxVu1kZvG8pa0jKkg5C
	7VIfmVw1YD5b97IKbkR8vEH5jrufrla3s0DBJZsaceRntZho330x7BQdFc1maqAjbblj/7VcDhk
	sHPM1zbexWQHPfn64E6p77/1GiBcH2mfk3LVU6PnB
X-Gm-Gg: ASbGnctJW9ClT+lQDlns8MItGDzPF93JmjDaftf4Aleq1eTXIWwah2RDIvYP1SehkpL
	u3C/QEWO++3tsNTz+y74AJbSeNsmsrMU0b4y2BMN9doTkmOQtpQFxnKCzzc+zBFEavKTzx98nOk
	gp8bC537KVFitjgU57Dh0M8uackdNhOeQzHxa/6iTskHMO77zL9n6o/L2RRAnqalZdxTa3f40G0
	U/lTMjztx3HReAaxz51S4Tq3pbqot+oMKdBYw==
X-Google-Smtp-Source: AGHT+IG8LNLF6elF+nO6H/dJ/B914rzyheDC8PdeWbrudWQf0D4Mt09IevsvYEeQqYwU4RwuXMjRFSNNNU2A5SHIGhY=
X-Received: by 2002:a17:902:d490:b0:234:9fd6:9796 with SMTP id
 d9443c01a7336-23e1ac3083fmr272935ad.19.1752520203756; Mon, 14 Jul 2025
 12:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250710082807.27402-1-byungchul@sk.com> <20250710082807.27402-4-byungchul@sk.com>
 <CAHS8izMXkyGvYmf1u6r_kMY_QGSOoSCECkF0QJC4pdKx+DOq0A@mail.gmail.com> <20250711011435.GC40145@system.software.com>
In-Reply-To: <20250711011435.GC40145@system.software.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 14 Jul 2025 12:09:51 -0700
X-Gm-Features: Ac12FXzUVPq18zdECD6VAkZou_cQw3_exQjRBAHBfJ-nI2-PNBKM8YMb1oroDfg
Message-ID: <CAHS8izNbE+sb8U2Ws2_0C9H6Tf2DzJjh2beu04uyzxk7xFw4ng@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/8] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org, 
	ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org, 
	akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com, 
	andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com, 
	tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com, 
	leon@kernel.org, ast@kernel.org, daniel@iogearbox.net, david@redhat.com, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, jackmanb@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 10, 2025 at 6:14=E2=80=AFPM Byungchul Park <byungchul@sk.com> w=
rote:
>
> On Thu, Jul 10, 2025 at 11:19:53AM -0700, Mina Almasry wrote:
> > On Thu, Jul 10, 2025 at 1:28=E2=80=AFAM Byungchul Park <byungchul@sk.co=
m> wrote:
> > >
> > > To simplify struct page, the effort to separate its own descriptor fr=
om
> > > struct page is required and the work for page pool is on going.
> > >
> > > To achieve that, all the code should avoid directly accessing page po=
ol
> > > members of struct page.
> > >
> > > Access ->pp_magic through struct netmem_desc instead of directly
> > > accessing it through struct page in page_pool_page_is_pp().  Plus, mo=
ve
> > > page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_des=
c
> > > without header dependency issue.
> > >
> > > Signed-off-by: Byungchul Park <byungchul@sk.com>
> > > Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> > > Reviewed-by: Mina Almasry <almasrymina@google.com>
> > > Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > Acked-by: Harry Yoo <harry.yoo@oracle.com>
> > > ---
> > >  include/linux/mm.h   | 12 ------------
> > >  include/net/netmem.h | 17 +++++++++++++++++
> > >  mm/page_alloc.c      |  1 +
> > >  3 files changed, 18 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/include/linux/mm.h b/include/linux/mm.h
> > > index 0ef2ba0c667a..0b7f7f998085 100644
> > > --- a/include/linux/mm.h
> > > +++ b/include/linux/mm.h
> > > @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_=
struct *t, unsigned long status);
> > >   */
> > >  #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
> > >
> > > -#ifdef CONFIG_PAGE_POOL
> > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > -{
> > > -       return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> > > -}
> > > -#else
> > > -static inline bool page_pool_page_is_pp(struct page *page)
> > > -{
> > > -       return false;
> > > -}
> > > -#endif
> > > -
> > >  #endif /* _LINUX_MM_H */
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index ad9444be229a..11e9de45efcb 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -355,6 +355,23 @@ static inline void *nmdesc_address(struct netmem=
_desc *nmdesc)
> > >         return page_address(nmdesc_to_page(nmdesc));
> > >  }
> > >
> > > +#ifdef CONFIG_PAGE_POOL
> > > +/* XXX: This would better be moved to mm, once mm gets its way to
> > > + * identify the type of page for page pool.
> > > + */
> > > +static inline bool page_pool_page_is_pp(struct page *page)
> > > +{
> > > +       struct netmem_desc *desc =3D page_to_nmdesc(page);
> > > +
> > > +       return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
> > > +}
> >
> > pages can be pp pages (where they have pp fields inside of them) or
> > non-pp pages (where they don't have pp fields inside them, because
> > they were never allocated from the page_pool).
> >
> > Casting a page to a netmem_desc, and then checking if the page was a
> > pp page doesn't makes sense to me on a fundamental level. The
> > netmem_desc is only valid if the page was a pp page in the first
> > place. Maybe page_to_nmdesc should reject the cast if the page is not
> > a pp page or something.
>
> Right, as you already know, the current mainline code already has the
> same problem but we've been using the werid way so far, in other words,
> mm code is checking if it's a pp page or not by using ->pp_magic, but
> it's ->lur, ->buddy_list, or ->pcp_list if it's not a pp page.
>
> Both the mainline code and this patch can make sense *only if* it's
> actually a pp page.  It's unevitable until mm provides a way to identify
> the type of page for page pool.  Thoughts?

I don't see mainline having a problem. Mainline checks that the page
is a pp page via the magic before using any of the pp fields. This is
because a page* can be a pp page or a non-pp page.

With netmem_desc, having a netmem_desc* should imply that the
underlying memory is a pp page. Having a netmem_desc* that is not
valid because the pp_magic is not correct complicates the code for no
reason. Every user of netmem_desc has to check pp_magic before
actually using the fields. page_to_nmdesc should just refuse to return
a netmem_desc* if the page is not a pp page.

Also, this patch has my Reviewed-by, even though I honestly don't see
it as acceptable and I clearly have feedback (and Pavel seems too?).

__please__, when you make significant changes to a patch, you have to
reset the Reviewed-by tags.

--=20
Thanks,
Mina


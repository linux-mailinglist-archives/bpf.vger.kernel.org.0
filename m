Return-Path: <bpf+bounces-32532-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C148D90F67C
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 20:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E9F1C24826
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 18:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A02D1586CD;
	Wed, 19 Jun 2024 18:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cQ2XuEsU"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8E015885C;
	Wed, 19 Jun 2024 18:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718822941; cv=none; b=ugoI9aCSKiv82nELc0omicQth0TtGIkluzO1DLNuGR//VKrUZcYlK0fDtdQJS8w0EyeqRaMcJWJWd0zyiD6oqL7W9/zDMeCY4tLbZd+jDj1h+r0yLB4vLYcp6sGJj9qxavGb+64JW3P5jWzXvD3wSkI1r4VwndQQZIBXy4iC+k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718822941; c=relaxed/simple;
	bh=qfTsdnJOq5fgxNKsMKUsFwWWyP0L9Eg9x4k1dvQW65E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPQHkp43smAe98ECZo2SV0Ez/vhwkmEY9ZUbdSrdmA0E0zOecxGTmKCXyvkgArzOzm5+RV925Qt/rzziIUEx/CwLcGXoiMbhjSy1JaUWhVjKIotwhitusNOEhdbD3foNh/p3ff72vubrGeltFgx0spS/fJH1Qr+jTOFPkiXYQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cQ2XuEsU; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42121d27861so1201965e9.0;
        Wed, 19 Jun 2024 11:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718822938; x=1719427738; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oOHV1OyPE5U8qTFJC5RPbb2z7vBlikoGyLR98RlK/24=;
        b=cQ2XuEsU/F0gQ8nqabK0nFVaDdRJmETj42lYNgSh8sdYHcO5EgSWXQNFvLp91uS86G
         1QXVPCj/8mBaM3Cg9qeKetrvvvVO/A/2u4kGTVYeUGiUjUg8EHUoOMwt9WuqwZCxaHgf
         040YjfD9xX2Xq4qWUxO/1+D3EUp/8A57ieb69/ne5lupXpz5izNAjR4fF0qTYy/kGeYj
         BEfxrW3DqyibmRsE6Zej0M8rTD2TzTqWtueVUZIhypYxHDY8KRIntXtK2gofERlY3Wx0
         3j94BEUBf9+A9QVbIm+8tKMKWb1JHiKqGpTDXV1W1LZPjZPr3PyzUp/nsWpq4Rxh2ak2
         pEXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718822938; x=1719427738;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oOHV1OyPE5U8qTFJC5RPbb2z7vBlikoGyLR98RlK/24=;
        b=PVXhonWYxXvn9Dh9/KvGxNKbnzVQnuDvKbVC3G5Ku1VvcGvgayTIbYg/HusxlkC1+p
         zlTbFB5XJ0/S6d11WQK8bb6+46xgY3C+GUGO6WlD1KlY13pwjWinpCy6LtZHYdtpgUT1
         MKAOUhI8Q8j6W43Vrx5pbEV6F7sEtqw/OhoQgQU6+pcSnRUnYUkDnK2Loqf3onoz92Dp
         HAdnqLE3H9qzC6imvkqRuM/B5c+hME7e1w371X+ydKdgl8iXwXxwnMAa1bwHsULShM+M
         mmY080TnyIc8d9HAKjvxZ928gSvIy1cRHl9T55zs3gqdDkWxqvHxMnq+cqRix/x/JoRr
         XaoQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe46GLTsXTpu89qWzk7itJi1hGeeL/OngngfLJUTwrEZoAbNJLy+p8ez9s7/2OaXwQyou8xQLK9rS2vh2rBKC3dudbP1UfIpaqo1dD5V7O881nyfDzHJv0PP5HhPk9AajJSiwPy81V4Gmr0GZlRqWo9PFXgOVrMojytZh3w10E/fMCdh2w
X-Gm-Message-State: AOJu0YwZBGPcD1C/O7JCUtZERQGQcVBmLnM8zxBcO7acoLQOX1dNj53o
	YKSAhJ26nZaXY0fSQMLDsg9gphUfM17CrSQXqbZNmDO9doftQ4gf
X-Google-Smtp-Source: AGHT+IH5y762c8nZSaoulqdoVkVT4/6AxhiQsd0NHTfK2saKY1Pbfyy3k1Bjd9mNU/P8yp98uATQQA==
X-Received: by 2002:a5d:4b4e:0:b0:362:ac86:4903 with SMTP id ffacd0b85a97d-36317b830c1mr2255111f8f.42.1718822938035;
        Wed, 19 Jun 2024 11:48:58 -0700 (PDT)
Received: from krava (85-193-35-215.rib.o2.cz. [85.193.35.215])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750f2263sm18022195f8f.83.2024.06.19.11.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 11:48:57 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 19 Jun 2024 20:48:55 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC bpf-next 01/10] uprobe: Add session callbacks to
 uprobe_consumer
Message-ID: <ZnMoF84ilUcEoiX5@krava>
References: <20240604200221.377848-1-jolsa@kernel.org>
 <20240604200221.377848-2-jolsa@kernel.org>
 <CAEf4BzbzgTzvnPRJ24gdhuxN02_w8iNNFn4URh0vEp-t69oPnA@mail.gmail.com>
 <20240605175619.GH25006@redhat.com>
 <ZmDPQH2uiPYTA_df@krava>
 <ZmHn43Af4Kwlxoyc@krava>
 <CAEf4BzaFcpqFc8w6dH5oOJNKsAXZjs-KCFAXLp8TMBtS5ooo4g@mail.gmail.com>
 <ZmbePPIKqc6XuVjL@krava>
 <CAEf4BzaqDSGBbaEuOpEW5NbosgN8jE4CUE8s+-dgs-0sV6_geA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzaqDSGBbaEuOpEW5NbosgN8jE4CUE8s+-dgs-0sV6_geA@mail.gmail.com>

On Mon, Jun 17, 2024 at 03:53:50PM -0700, Andrii Nakryiko wrote:
> On Mon, Jun 10, 2024 at 4:06 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Jun 06, 2024 at 09:52:39AM -0700, Andrii Nakryiko wrote:
> > > On Thu, Jun 6, 2024 at 9:46 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > > >
> > > > On Wed, Jun 05, 2024 at 10:50:11PM +0200, Jiri Olsa wrote:
> > > > > On Wed, Jun 05, 2024 at 07:56:19PM +0200, Oleg Nesterov wrote:
> > > > > > On 06/05, Andrii Nakryiko wrote:
> > > > > > >
> > > > > > > so any such
> > > > > > > limitations will cause problems, issue reports, investigation, etc.
> > > > > >
> > > > > > Agreed...
> > > > > >
> > > > > > > As one possible solution, what if we do
> > > > > > >
> > > > > > > struct return_instance {
> > > > > > >     ...
> > > > > > >     u64 session_cookies[];
> > > > > > > };
> > > > > > >
> > > > > > > and allocate sizeof(struct return_instance) + 8 *
> > > > > > > <num-of-session-consumers> and then at runtime pass
> > > > > > > &session_cookies[i] as data pointer to session-aware callbacks?
> > > > > >
> > > > > > I too thought about this, but I guess it is not that simple.
> > > > > >
> > > > > > Just for example. Suppose we have 2 session-consumers C1 and C2.
> > > > > > What if uprobe_unregister(C1) comes before the probed function
> > > > > > returns?
> > > > > >
> > > > > > We need something like map_cookie_to_consumer().
> > > > >
> > > > > I guess we could have hash table in return_instance that gets 'consumer -> cookie' ?
> > > >
> > > > ok, hash table is probably too big for this.. I guess some solution that
> > > > would iterate consumers and cookies made sure it matches would be fine
> > > >
> > >
> > > Yes, I was hoping to avoid hash tables for this, and in the common
> > > case have no added overhead.
> >
> > hi,
> > here's first stab on that.. the change below:
> >   - extends current handlers with extra argument rather than adding new
> >     set of handlers
> >   - store session consumers objects within return_instance object and
> >   - iterate these objects ^^^ in handle_uretprobe_chain
> >
> > I guess it could be still polished, but I wonder if this could
> > be the right direction to do this.. thoughts? ;-)
> 
> Yeah, I think this is the right direction. It's a bit sad that this
> makes getting rid of rw_sem on hot path even harder, but that's a
> separate problem.
> 
> >
> > thanks,
> > jirka
> >
> >
> > ---
> > diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
> > index f46e0ca0169c..4e40e8352eac 100644
> > --- a/include/linux/uprobes.h
> > +++ b/include/linux/uprobes.h
> > @@ -34,15 +34,19 @@ enum uprobe_filter_ctx {
> >  };
> >
> >  struct uprobe_consumer {
> > -       int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
> > +       int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs,
> > +                       unsigned long *data);
> 
> can we use __u64 here? This long vs __u64 might cause problems for BPF
> when the host is 32-bit architecture (BPF is always 64-bit).

ok

> 
> >         int (*ret_handler)(struct uprobe_consumer *self,
> >                                 unsigned long func,
> > -                               struct pt_regs *regs);
> > +                               struct pt_regs *regs,
> > +                               unsigned long *data);
> >         bool (*filter)(struct uprobe_consumer *self,
> >                                 enum uprobe_filter_ctx ctx,
> >                                 struct mm_struct *mm);
> >
> 
> [...]
> 
> >  static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >  {
> >         struct uprobe_task *n_utask;
> > @@ -1756,11 +1795,11 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >
> >         p = &n_utask->return_instances;
> >         for (o = o_utask->return_instances; o; o = o->next) {
> > -               n = kmalloc(sizeof(struct return_instance), GFP_KERNEL);
> > +               n = alloc_return_instance(o->session_cnt);
> >                 if (!n)
> >                         return -ENOMEM;
> >
> > -               *n = *o;
> > +               memcpy(n, o, ri_size(o->session_cnt));
> >                 get_uprobe(n->uprobe);
> >                 n->next = NULL;
> >
> > @@ -1853,35 +1892,38 @@ static void cleanup_return_instances(struct uprobe_task *utask, bool chained,
> >         utask->return_instances = ri;
> >  }
> >
> > -static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs)
> > +static struct return_instance *
> > +prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
> > +                 struct return_instance *ri, int session_cnt)
> 
> you have struct uprobe, why do you need to pass session_cnt? Also,
> given return_instance is cached, it seems more natural to have
> 
> struct return_instance **ri as in/out parameter, and keep the function
> itself as void

I tried that, but now I think it'd be better if we just let prepare_uretprobe
to allocate (if needed) and free ri in case it fails and do something like:

       if (need_prep && !remove)
               prepare_uretprobe(uprobe, regs, ri); /* put bp at return */
       else
               kfree(ri);

> 
> >  {
> > -       struct return_instance *ri;
> >         struct uprobe_task *utask;
> >         unsigned long orig_ret_vaddr, trampoline_vaddr;
> >         bool chained;
> >
> 
> [...]
> 
> >         if (need_prep && !remove)
> > -               prepare_uretprobe(uprobe, regs); /* put bp at return */
> > +               ri = prepare_uretprobe(uprobe, regs, ri, uprobe->session_cnt); /* put bp at return */
> > +       kfree(ri);
> >
> >         if (remove && uprobe->consumers) {
> >                 WARN_ON(!uprobe_is_active(uprobe));
> >                 unapply_uprobe(uprobe, current->mm);
> >         }
> > + out:
> >         up_read(&uprobe->register_rwsem);
> >  }
> >
> > +static struct session_consumer *
> > +consumer_find(struct session_consumer *sc, struct uprobe_consumer *uc)
> 
> why can't we keep track of remaining number of session_consumer items
> instead of using entire extra entry as a terminating element? Seems
> wasteful and unnecessary.

ok I think it's possible, will try that

thanks,
jirka


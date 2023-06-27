Return-Path: <bpf+bounces-3579-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 224E7740192
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 18:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E13280ED5
	for <lists+bpf@lfdr.de>; Tue, 27 Jun 2023 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92C613070;
	Tue, 27 Jun 2023 16:44:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8F91373
	for <bpf@vger.kernel.org>; Tue, 27 Jun 2023 16:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D740DC433C0;
	Tue, 27 Jun 2023 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884266;
	bh=lHpE7is/FZcQr+hDU6WcWf9dfsLK5ZXUTlGo/Cptkaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VY+hhdpFmdc935OmKzseZ1dgmGT0CymD+28Bt3tziPVxEilu4rKvy5y8Vqpe3qhhG
	 RWYXsXlVuCTBMew1JuSb9PAvEjwwdM/ocuY9rizMxh5HBo0utu0YApFNi1qms8P9Pu
	 ohZpvFwytPjJCF2JqiWHbcHzlH/AIHLkvrbkpyZkcdfJ/wZd/NY15eynAKOvfzxP7P
	 fA6isFbK4J3ksTW5+RhkA1WgrH6+eyWZwVz9oo3p/9j/8Vd1sMUy+yEmvvH0qp1qCI
	 XFyIfbY5qDsGzlsotH9z6hJo8wGp+eVyQJvk1gOo+SMVOp4UL52kGrDb1BbVtyDqY1
	 qHNgzl5AyBfVQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	martin.lau@linux.dev,
	ast@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Egorenkov <Alexander.Egorenkov@ibm.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] btf: warn but return no error for NULL btf from __register_btf_kfunc_id_set()
Date: Tue, 27 Jun 2023 16:44:24 +0000
Message-Id: <20230627164424.81241-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230627163750.81178-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 27 Jun 2023 16:37:50 +0000 SeongJae Park <sj@kernel.org> wrote:

> Hi Jiri,
> 
> On Tue, 27 Jun 2023 18:20:39 +0200 Jiri Olsa <olsajiri@gmail.com> wrote:
> 
> > On Mon, Jun 26, 2023 at 06:11:20PM +0000, SeongJae Park wrote:
> > > __register_btf_kfunc_id_set() assumes .BTF to be part of the module's
> > > .ko file if CONFIG_DEBUG_INFO_BTF is enabled.  If that's not the case,
> > > the function prints an error message and return an error.  As a result,
> > > such modules cannot be loaded.
> > > 
> > > However, the section could be stripped out during a build process.  It
> > > would be better to let the modules loaded, because their basic
> > > functionalities have no problem[1], though the BTF functionalities will
> > > not be supported.  Make the function to lower the level of the message
> > > from error to warn, and return no error.
> > > 
> > > [1] https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> > > 
> > > Reported-by: Alexander Egorenkov <Alexander.Egorenkov@ibm.com>
> > > Link: https://lore.kernel.org/bpf/87y228q66f.fsf@oc8242746057.ibm.com/
> > > Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> > > Link: https://lore.kernel.org/bpf/20220219082037.ow2kbq5brktf4f2u@apollo.legion/
> > > Fixes: dee872e124e8 ("bpf: Populate kfunc BTF ID sets in struct btf")
> > 
> > should it be this one in Fixes instead?
> >   c446fdacb10d bpf: fix register_btf_kfunc_id_set for !CONFIG_DEBUG_INFO_BTF
> 
> The commit c446fdacb10d was trying to fix commit dee872e124e8, which this patch
> is claiming to fix, by relaxing the check.  Nevertheless, it seems the check
> need to further relaxed, and therefore I wrote this patch.
> 
> For the reason, I was thinking this patch is directly fixing c446fdacb10d, but
> is also fixing a problem originally introduced by dee872e124e8.   Nevertheless,
> as the dee872e124e8 also has the Fixes tag, I think your suggestion makes

s/dee872e124e8 also has /c446fdacb10d also has /

Sorry if it made anyone be confused.


Thanks,
SJ

[...]


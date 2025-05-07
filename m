Return-Path: <bpf+bounces-57593-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 97082AAD23A
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 02:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 713571BA8B95
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 00:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55DE11CA9;
	Wed,  7 May 2025 00:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXbX07mM"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ECCA23DE;
	Wed,  7 May 2025 00:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746577302; cv=none; b=KuOnpBs2z5sbq9pzdanIieOzli/kxvkrgZMcet9uBpTaboaYVvEemoGVnxprM/RfjNaovdl3O8AxAvcF7dqC8KuCyi64gdyq04yGyxazZeF1gpd5aRCRxfeDaYRU9K0dA1A3aYhjCi22V4xoDJK4/G9qTe7cGzmTbUa/wAsMuF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746577302; c=relaxed/simple;
	bh=imNfF9iMlp377Q67WylkmovEDghyzTyehxE1g7lwRfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvSKVK86BA6h3+Kt41kGRE1Czb/U1PkEZUw1DHBKLnkkhsQga1K/S1nu5ojR65fyE4R84dypBnz+4QJKh25H0SOWbfwc+rBd3Uy6+6CUACK6PSC0tssStDaDUFLXzk02YgcggX7ahhbU/3oal5Bba/S04YDrw1ZtdJU0F9PNi7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXbX07mM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CC0C4CEE4;
	Wed,  7 May 2025 00:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746577301;
	bh=imNfF9iMlp377Q67WylkmovEDghyzTyehxE1g7lwRfE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VXbX07mMuCpkNiBHJN4rmrgcdmUORSQLm6IgjNzunCN5sfoWgzFLvNkuYZdUE7ECO
	 eOd+g/+mj+keiM5IvV7mpm0XfueHPLgr25+sOUJqoO6oKMnLZUC6Nm4lp1PKtolQ49
	 HfiJDRYaMAQMhNHwFUeLsw93Zg8aVjpvL5uR8Sm6dUBIzHwcwjotgbn5g73tUKFB+Y
	 VC28aACt3MYqgq/a7LtAi4F7wtRy/sHlP+XVECundMVQ4A2YXMhICtkchUkYJXrDVD
	 eGvWGmmb2QKOtCW2Ond1HhS+zzzt/kH/NlHmP7n/SNawCMas6xSNyll2nXIO6ks2N2
	 EAGrveoT5N1CA==
Date: Tue, 6 May 2025 14:21:40 -1000
From: Tejun Heo <tj@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Feng Yang <yangfeng59949@163.com>, martin.lau@linux.dev, ast@kernel.org,
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
	jolsa@kernel.org, mattbobrowski@google.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
	davem@davemloft.net, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 sched_ext 2/2] sched_ext: Remove bpf_scx_get_func_proto
Message-ID: <aBqnlHvfMdYu3JH8@slm.duckdns.org>
References: <20250506061434.94277-1-yangfeng59949@163.com>
 <20250506061434.94277-3-yangfeng59949@163.com>
 <CAEf4BzbqrvgD11M5nTwP=oJeNph6n63qAZfW8Qu=MB9k3h_-ow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbqrvgD11M5nTwP=oJeNph6n63qAZfW8Qu=MB9k3h_-ow@mail.gmail.com>

On Tue, May 06, 2025 at 03:30:39PM -0700, Andrii Nakryiko wrote:
> On Mon, May 5, 2025 at 11:15 PM Feng Yang <yangfeng59949@163.com> wrote:
> >
> > From: Feng Yang <yangfeng@kylinos.cn>
> >
> > task_storage_{get,delete} has been moved to bpf_base_func_proto.
> >
> > Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> > Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
> > ---
> >  kernel/sched/ext.c | 15 +--------------
> >  1 file changed, 1 insertion(+), 14 deletions(-)
> >
> 
> Given this has dependency on patch #1, we should either route this
> patch through bpf-next, or we'll have to delay and resend it after
> merge window.
> 
> Tejun, any preferences?

Yeah, bpf-next sounds good to me and please feel free to add:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun


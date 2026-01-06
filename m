Return-Path: <bpf+bounces-77911-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 089E6CF6706
	for <lists+bpf@lfdr.de>; Tue, 06 Jan 2026 03:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1869B304718B
	for <lists+bpf@lfdr.de>; Tue,  6 Jan 2026 02:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CFB247295;
	Tue,  6 Jan 2026 02:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVIMXYqk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6316246BCD
	for <bpf@vger.kernel.org>; Tue,  6 Jan 2026 02:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665751; cv=none; b=WJ6dLzqSHV+nJtr6FMDOopkOhpCZmTZGWc0U3+//fVWP/UWoXUpoFnl4rBaR7UzTq93KIe9Dfn0Hy0HP/6AiFaMG0IR1C53bBWi5YOVkqHhGDo/X+nzOeuFfCpCECnVkZ1++pzPBPOalJwuFk1w5XNsF1G618Kj9gOGYO0DVP+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665751; c=relaxed/simple;
	bh=CsMhaJvutyGAYswigpsd3Er9zcC3D6NC3P6YF/TW7k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gLP0vYq3xV7kIl01bjsHLooEDYnHbMXz1zQvUME7b3j/M6Y7mAk3O0GaYRd3/foHNEawswYtpVx6tCM0kdHmeDb+lAlvbugdCBEG5i88DlfLeuXGm3qudYuiQDQYgD1V63ynhdklqkDLo0KUXCkNClG6HRxa24/j3pHq/L0twbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVIMXYqk; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so306499f8f.1
        for <bpf@vger.kernel.org>; Mon, 05 Jan 2026 18:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767665747; x=1768270547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SDhzKCEhlnuieuWzeq5yiYuir1bwBk2FS7bsiPbikHA=;
        b=HVIMXYqkf7wUYYvK4IrWj3nTJS4+EhDJBX+pDqLFivdKdHKolfJDK4SQ8kaJhllG/E
         JAafSVyEhgfTadeKabm771v8YbS7SHJSgU6x74nz5FHtG/ccfeNX1Zrus8Zxs5iNW3iM
         3Z6ldnNbqRDJWlx4Ho0T0AzSShcmf9oOvCcOClF+JYFaKWnu9r+1pMPIgh34jADO4t7g
         9t5suaumlpoHRxupBKLG6gWWhADKMQpDuU4mas50z/agN6k0GxdlCFPz20Htj97FUv4P
         8mVmutWpqrwPxryDosd+T6jEsn61q1H5amYvKmpPhvGvzGQMiy0fLEkwLWUXwimNF0Nh
         eqLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767665747; x=1768270547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SDhzKCEhlnuieuWzeq5yiYuir1bwBk2FS7bsiPbikHA=;
        b=QywqFhckfCYrZdqw1rUqWG8Vvx0TF9psO8EbzG1rDKUIhtZFfMy2g/EPGXBxM8orGI
         tTKEfYPATs779A+ki1+FvDzREWIHgNpZ873g0IbpnXQIdSN6l4NHzchsDGR+AfqlJQDf
         C8JVXDKOYPzawBlhbaDLEDs2CDZ5bCS0MvTc/gpan225C/0NU+JZegVk9bEdLIt0gZgY
         I0lur5OEsmuWt2+2BRLd/viB8Ae4EIqlOZDqo0HbjFM++8oymTBBKWMXIOUptHSuzmg8
         GhE0wqTr6sxLFUpKIBKfp6IZcGOpX835eZmrDyNaQe742L4Le1Own2+hgAUYEjXTOi0J
         5vVg==
X-Forwarded-Encrypted: i=1; AJvYcCVnS3NAybnUzDu3BU0B3duzbYf0lIPVap5RvnSujefwnbejRtMCFdDT2rN3bSs3DwncT+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19Ei2PXtKzuArJWaqVsyN00Ek4oEc8Zt78N7L8jrMH7k9VgbV
	rcpENcML0Dhbz3+c7hXQ4rzrtTy6e+L/Lirk7URhcq29s0Q7utQiysdjpfVyUmPP5Deuv5s/hxi
	vdHvc/5YtdUJc9dQrast8EYN3ifJSzkc=
X-Gm-Gg: AY/fxX6riSHAEfyqMA5m6CC5ueIzYITzfPjkYDfzMAVIitaNdPH+zotjTIsHTPN0jvv
	Ly6dacuYKaa1DWTdsBqN/JwxjF8tMPtazlrgJ6BJT3JYcpze1v2h5sXdCv/Qo+eJ7wavtJl6tm+
	ZONwClxWpzvte4vdJZUi/Mjif6bbz3W/hIGvxvkRJ7889M1VVEbzdSMXvjUkqxvYTdRC6HK8adm
	3eRngJ9Vjo8FFoJTpgBe9qDs613JkW01HKVCufiupLJP04T3LdHj6Y+QSlQmmG+Sr2L/arbD9D5
	RalshH59Hq8cErlZYKHut/uzkfw2
X-Google-Smtp-Source: AGHT+IH7ZluxX2wfvT3xpq91hTg7MZMEYPiM0ad6034ERy8mDJruijzlFcdACHHyo4XoPbd80qA+JjQttmgrpCIv3rU=
X-Received: by 2002:a05:6000:2891:b0:430:f6bc:2f8b with SMTP id
 ffacd0b85a97d-432bc9fc52amr2436368f8f.45.1767665747073; Mon, 05 Jan 2026
 18:15:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260105130413.273ee0ee@canb.auug.org.au>
In-Reply-To: <20260105130413.273ee0ee@canb.auug.org.au>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 5 Jan 2026 18:15:36 -0800
X-Gm-Features: AQt7F2qLl3PtXa1b7Azrz9jEfO1E_QU1sCOfMhqpYy96XLMMFtYZeuNavxCi0x4
Message-ID: <CAADnVQKkphWpwKE17bGQao36dH8xqCyV-iXDcagrO7s-VOPE-w@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the
 mm-unstable tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, Chen Ridong <chenridong@huawei.com>, 
	JP Kobryn <inwardvessel@gmail.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 4, 2026 at 6:04=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the bpf-next tree got a semantic conflict in:
>
>   include/linux/memcontrol.h
>   mm/memcontrol-v1.c
>   mm/memcontrol.c
>
> between commit:
>
>   eb557e10dcac ("memcg: move mem_cgroup_usage memcontrol-v1.c")
>
> from the mm-unstable tree and commit:
>
>   99430ab8b804 ("mm: introduce BPF kfuncs to access memcg statistics and =
events")
>
> from the bpf-next tree producing this build failure:
>
> mm/memcontrol-v1.c:430:22: error: static declaration of 'mem_cgroup_usage=
' follows non-static declaration
>   430 | static unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, b=
ool swap)
>       |                      ^~~~~~~~~~~~~~~~
> In file included from mm/memcontrol-v1.c:3:
> include/linux/memcontrol.h:953:15: note: previous declaration of 'mem_cgr=
oup_usage' with type 'long unsigned int(struct mem_cgroup *, bool)' {aka 'l=
ong unsigned int(struct mem_cgroup *, _Bool)'}
>   953 | unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swa=
p);
>       |               ^~~~~~~~~~~~~~~~
>
> I fixed it up (I reverted the mm-unstable tree commit) and can carry the
> fix as necessary. This is now fixed as far as linux-next is concerned,
> but any non trivial conflicts should be mentioned to your upstream
> maintainer when your tree is submitted for merging.  You may also want
> to consider cooperating with the maintainer of the conflicting tree to
> minimise any particularly complex conflicts.

Hey All,

what's the proper fix here?

Roman,

looks like adding mem_cgroup_usage() to include/linux/memcontrol.h
wasn't really necessary, since kfuncs don't use it anyway?
Should we just remove that line in bpf-next?

Just:
diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index 6a5d65487b70..229ac9835adb 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -950,7 +950,6 @@ static inline void mod_memcg_page_state(struct page *pa=
ge,
 }

 unsigned long memcg_events(struct mem_cgroup *memcg, int event);
-unsigned long mem_cgroup_usage(struct mem_cgroup *memcg, bool swap);
 unsigned long memcg_page_state(struct mem_cgroup *memcg, int idx);
 unsigned long memcg_page_state_output(struct mem_cgroup *memcg, int item);
 bool memcg_stat_item_valid(int idx);

compiles fine.

If you agree pls send an official patch.


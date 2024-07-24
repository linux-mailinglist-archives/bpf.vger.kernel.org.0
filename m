Return-Path: <bpf+bounces-35510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6734C93B2CE
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 16:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 976851C2387C
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2024 14:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C8015AD95;
	Wed, 24 Jul 2024 14:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="i+8l/EAR"
X-Original-To: bpf@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147E815884F;
	Wed, 24 Jul 2024 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831977; cv=none; b=SESb66/jjE8D/VwPnl6msw7o2KQJ+KgQjtpcJ7UrMD2QEnawobxRWvsOlUrHwkqPDSTfy8AOSqe3PQoGwnQhsFKPMT44RQ+Pv96qAjOERNkZOURP813b+dWuaj50n5ykwkWsuoIeTFInf0MpbAFTODHiSEd3iedLEfYeQ7qt3Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831977; c=relaxed/simple;
	bh=cIBE3pmrEBO44fxkfy01RJ9NS/eu73nXnkd1UUkSvD0=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=oo5HQOsotzTe42UcUrzci9pqOLz+ol4p2KONpZYMdeci8UVu9KG6ZtSrXxzH1pYe3tt620qpmCUqc+WjeYBps0tsWV5+DgwMbC92jBlbu9eygongYc2eoJRHnvyOL1u6xuvJUtLC4zwlfFnIGmRDjzIkSDOoShqzispwiHemaDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=i+8l/EAR; arc=none smtp.client-ip=212.227.15.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1721831943; x=1722436743; i=markus.elfring@web.de;
	bh=X+lF6KydkivclEQq2sQLYk3Y7ZVoGicPD79PSLS8v+0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=i+8l/EARM6oUMXwUXNQ7jnF3jvQCTsBI3DxlaQ3KZg/7cC/gsNtO0tczGQqLbrY5
	 0zf990SIDBmJgTPihn0NYjPAYc2PC6KfDitaVWa2f/pL5kLvBOz/lA1jk9j+bBktN
	 l8KCku/JYC2JY8lmxkHyH4x2AJKpe5FepW5SyfaSCTL3bo0ZXGKG46gDFCpiH7R5Y
	 i3XaosuNgK5zZX7GYRBtg6T7RAID0Vvw+2EZqVeiQ34xsx+nFWkB3RhkDKVZ98TIg
	 VVAJQs14NoeHXHzMk2dUd74ykMoxhN4G8J8bxVFDQXoJACylnUfBmT6Xj6TTyF3LB
	 Anbhquz7Utj0hu6s7A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Myezp-1sMeyY02Fp-00uID1; Wed, 24
 Jul 2024 16:39:03 +0200
Message-ID: <9c0b08f9-7c0b-4452-bbd2-a7e23bbcf572@web.de>
Date: Wed, 24 Jul 2024 16:38:58 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhu Jun <zhujun2@cmss.chinamobile.com>, bpf@vger.kernel.org,
 Quentin Monnet <qmo@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Hao Luo <haoluo@google.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Yonghong Song <yonghong.song@linux.dev>
References: <20240724100022.10850-1-zhujun2@cmss.chinamobile.com>
Subject: Re: [PATCH v3] tools/bpf: Fix the wrong format specifier
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240724100022.10850-1-zhujun2@cmss.chinamobile.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cOeI2VXa4drhmPAopDibrmivHRd2mFb3VkA/x1zPkm/X7u955mg
 N+0QQNakh/xUDqYcwAFrn2R8N/6lI7ShQlAL76xFY48/Hq3uX43JgtqaUX3FAe5Jo3vtY5j
 LKsCelKWmV+9mxozE8X+Ij7+h4oDj/T5yBUiqnHwNkn+y78gMkca/abhws51elqw6ZIhgju
 RdRgCozLf5e46bRW463Rw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xNEdeAFuVaQ=;4KTw/eCux71gG4bWYi3e3zBcYej
 wmBTK50LLmYyUY2i7PifnylNLED3oVr/CG6mksGz/ZvbV7ZyJvmzh/1EcgL78pTi6EBVgmAaH
 7I3j6jnO9qqVFY9rztXPnuuiSl7TPfQVoe7MblMxteytv22DrhyZCNsQcmkwIm94i5ulMJSD4
 ucJfks35iyNQyGGk9KI5ANLmJy0JRETAS/KMG20F/Ni6hWWQWPEGeod+dJUcttYDmo3gYjK1Y
 Es4aK03Gdk58ENs/g9nXoLCmWEwG1RkdIqRYOz/1LrU34I7QlHb1t0q1bFgmx0ZrNaZlTZDpm
 uHvALFSK8mbCdS5ZR+Gr6ApCp6PWpqcGzzBnC2vsReTBhaq7kLT6G+9P27hS6Ez0fLJ+OApmH
 ikPiDEexnI0mQDlJtt5mbxDI/vSvF8Rax+JeXpfw3QDCT+tLhjskbNM3maMReM+CKNPo0PX6M
 BkkqLG0Ni5wv0ihpwK1fh8WW10QAoikZOZLKMZt178D5RoupNzXjxPdfY4Ex10OsLhCZ7IIG5
 QdXirPXpUcFTpwAFSRNajJ6WTA+0wlGmIZO9sTiN4v8kZsbEswIYacvWSa8sg5OuVC078RVPV
 cSMP/+RZ81p3jzDAPJZmRZbcelhk6IkE9BZrWgP08u1wGXdZqTeV51ooNP5FFN/PUoU2SvhDO
 iNhMteG2CeHsZXYHVJdOxkG54alaIM/A35ZJodM1OIXzDrSTG89hzddjkPBjJd7ALc/VhxQs5
 vL7jaeEWH1DLrZrUaoJ8eGFMFA9uR4Uq0KLkzHsgw96HYO/RlvBSMl6hN82ZYZeZE9aki3jA8
 BA8GG71hh0S60hs+S5Rzo19g==

> The format specifier of "unsigned int" in printf() should be "%u", not
> "%d".

Would you like to add any tags (like =E2=80=9CFixes=E2=80=9D and =E2=80=9C=
Cc=E2=80=9D) accordingly?


=E2=80=A6
> ---
> Changes:
=E2=80=A6
> v3:fix compile warninf

V3:
Fix a compilation warning?


=E2=80=A6
> +++ b/tools/bpf/bpftool/xlated_dumper.c
> @@ -316,7 +316,7 @@ void dump_xlated_plain(struct dump_data *dd, void *b=
uf, unsigned int len,
=E2=80=A6
> -	unsigned int i;
> +	int i;

Please do not change the data type for the variable
if you would like to adjust a subsequent format string.


=E2=80=A6
> @@ -415,7 +415,7 @@ void dump_xlated_for_graph(struct dump_data *dd, voi=
d *buf_start, void *buf_end,
>  			}
>  		}
>
> -		printf("%d: ", insn_off);
> +		printf("%u: ", insn_off);
>  		print_bpf_insn(&cbs, cur, true);
=E2=80=A6

How do you think about to care more also for the return value from such a =
function call?
https://wiki.sei.cmu.edu/confluence/display/c/ERR33-C.+Detect+and+handle+s=
tandard+library+errors

Regards,
Markus


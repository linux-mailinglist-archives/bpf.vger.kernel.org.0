Return-Path: <bpf+bounces-69442-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87EB6B96A6B
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 17:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37D9A7ADFB6
	for <lists+bpf@lfdr.de>; Tue, 23 Sep 2025 15:46:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D68EB274B5C;
	Tue, 23 Sep 2025 15:47:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C1726563B;
	Tue, 23 Sep 2025 15:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758642447; cv=none; b=MvZzdCv6AOMNsOidCosszJpuxfsmJieNEbtuIyRm4Slfvm08iK50AsaswokChjixivVj55lOYB03HmhxSWVF7CN/en3L9Y1t3kyZWH+RTpZuT4FiRRNcKwePKJO+EDym1oZM/zgiYgSaVHxWeZYtHZ8+hAQk7RYvRNvGrbcHJf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758642447; c=relaxed/simple;
	bh=7HziM51fokJHC3jC9oA36jkC79HdJut8P+XATs1vbWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7EpWIYBQO/FkPOfxmWvfbfpTyftiznoySmYmcVvWjBkFkW6VRq+J7ct5u31ldtn+teoUgA62Ke+odLUs3TSLCMNic0dl0HtemlVzTwVRcaP1AYFhyzl4M9+IrqdNQOFTJzY+a9xbnvQlDiSK/zn+1OgdWgnHB+EJ48+Dzpvvew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 556FAB9B6F;
	Tue, 23 Sep 2025 15:47:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id C805A2000E;
	Tue, 23 Sep 2025 15:47:14 +0000 (UTC)
Message-ID: <a54094681531e526c7e055cc5f58d0f6d480c119.camel@perches.com>
Subject: Re: [PATCH 20/34] checkpatch: Deprecate rcu_read_{,un}lock_trace()
From: Joe Perches <joe@perches.com>
To: "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org, Andrew
 Morton	 <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, rostedt@goodmis.org,
  Andy Whitcroft <apw@canonical.com>, Dwaipayan Ray
 <dwaipayanray1@gmail.com>, Lukas Bulwahn	 <lukas.bulwahn@gmail.com>, Andrii
 Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Date: Tue, 23 Sep 2025 08:47:13 -0700
In-Reply-To: <20250923142036.112290-20-paulmck@kernel.org>
References: <580ea2de-799a-4ddc-bde9-c16f3fb1e6e7@paulmck-laptop>
	 <20250923142036.112290-20-paulmck@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: C805A2000E
X-Stat-Signature: xyhh66ziobi3gt9nhn481wgoykujxgp9
X-Rspamd-Server: rspamout06
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19zGYIWzQffe4MRCC7e4CCIFAD8auaCiSk=
X-HE-Tag: 1758642434-818505
X-HE-Meta: U2FsdGVkX1/xO5shmau56dp57ipcWIiBFvH+NXf0PoWoiEpKQHyCrp552WPbVra/f93h++X01J5fyAsz324EKPppFjaovdpkDqlMLyS9hvcdFVuH1ljbUAie8MgXUeMS3Ikqj0W3mL6QoKRY79EUEiv7K/8lqHEQGhA1OWJYQTzbWpDDc5ccYo/CUNkyeFKV1Au4c2RyNmiWIvJemq7yAoyiSO8h6TVMnGoGYPPX3jnpfYlsOdMPzjTYBP6rfO6mrOfMxumVGfLr+IQGr62mcYb2kCqc3sCrJDDYjlskwr2ZDyUqTjZOTUnwUL4QeuKJPSsNvvxlaf0dkeco9LtdPVZttRCM6H7/0RXDrfxXM+VaI97lQtOU/+rtcbYpS+IwhyTf2SjMmXT4SgRirOlgOMIGpWWSkDzrl+A0Nl7cnmsCBifrvPDqlYgY7EAkohXt4F1bt+LPn0rd7d4gEOrlR3SGWyQ7sT+YRWgEHZr+2SQrZdEO8aPuiLv6qQFBUkG73TUyzIu1S1mznK10yoAWkizN5xf+yzy+4vODWYNOasI=

On Tue, 2025-09-23 at 07:20 -0700, Paul E. McKenney wrote:
> Uses of rcu_read_lock_trace() and rcu_read_unlock_trace()
> are better served by the new rcu_read_lock_tasks_trace() and
> rcu_read_unlock_tasks_trace() APIs.  Therefore, mark the old APIs as
> deprecated.
>=20
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

Acked-by: Joe Perches <joe@perches.com>

> Cc: Andy Whitcroft <apw@canonical.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Dwaipayan Ray <dwaipayanray1@gmail.com>
> Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Cc: Andrii Nakryiko <andrii@kernel.org>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: <bpf@vger.kernel.org>
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index e722dd6fa8ef3d..3bb7d35a5cfcba 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -860,6 +860,8 @@ our %deprecated_apis =3D (
>  	"kunmap"				=3D> "kunmap_local",
>  	"kmap_atomic"				=3D> "kmap_local_page",
>  	"kunmap_atomic"				=3D> "kunmap_local",
> +	"rcu_read_lock_trace"			=3D> "rcu_read_lock_tasks_trace",
> +	"rcu_read_unlock_trace"			=3D> "rcu_read_unlock_tasks_trace",
>  );
> =20
>  #Create a search pattern for all these strings to speed up a loop below


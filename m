Return-Path: <bpf+bounces-47741-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 983D09FF648
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 06:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C2E5162146
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 05:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5690118BBAC;
	Thu,  2 Jan 2025 05:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aL4d7jKe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067674315E;
	Thu,  2 Jan 2025 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735796291; cv=none; b=UAlER0UCs+hk7vtMhPmM2uhgQ5XO14Qdl94qCNXgIGN2abdn82HsxevrjkkokLtC01yavVackgmVZD4te4N0vU5uX64WpreVN+w9+p0BoKOzjwNuFV6rT9z1ungCRi4+iwQ0XB+mzJe3T9eh+chiLj2vI2jeKWX+6vKaXGcw67A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735796291; c=relaxed/simple;
	bh=GBz25TqCg1gEAmNPJzG6XWjmsOAvGS3zaLKi157/1+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gderAOGxqaIy4XxbcOGrt+SvEUZmsbv7K3ih+KwhI5JfCVrGlo82FlHHZoki03MFLMvupCJY90hPJc+WqZaj2m26x9kmUDpvBG361DYgR56+4QVeKea0SJZmT5hbFiOG8A8IMVBvuLCX0BXhh8On5cki6aF6oazrU9S5yT934ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aL4d7jKe; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501KlLEM008711;
	Thu, 2 Jan 2025 05:37:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=eg4Fl9
	mNLoRP2XFOH1wDCUzePu3zwBZJdjFFc1eUlj4=; b=aL4d7jKeRweKhrp42JV91v
	JX8/8K3WaRTyyJ0R2cXm1fzmaZrGigvDRgqYpsnOLnEaPu0XKMM2iZZSTTeGVBSa
	0VDMgqk8Dok6lgyOICbwTnDcoqleebv3AvrfuP1Iyca3uXn0omZkAI4xMLbULJCb
	P+qRm3UYxUP849aIwrxtFAyXMqrIWStZJ+e9c5XkGIW+tonw2SwXWOQLi9ZeDvI2
	T0E7jsPZtj5Gk18VQbeL2t59u9aKu5B9aG1bXKGLzjmY2GQ/odG/kdCPRn9XA0Xx
	B4DjKTmzQ3VnZzYPsK8JAm3UZXZBt3FNR6MtMq8oobfAeSU5r75C4dg3plwiCYaQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43w7649xhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 05:37:29 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5025YuNa015477;
	Thu, 2 Jan 2025 05:37:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43w7649xh8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 05:37:28 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5024BUt7010120;
	Thu, 2 Jan 2025 05:37:27 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tvnngvyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 05:37:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5025bNn762456224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jan 2025 05:37:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C7D4620043;
	Thu,  2 Jan 2025 05:37:23 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F58920040;
	Thu,  2 Jan 2025 05:37:19 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown [9.109.199.160])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  2 Jan 2025 05:37:19 +0000 (GMT)
Date: Thu, 2 Jan 2025 11:07:06 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Daniel Gomez <da.gomez@samsung.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 1/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
Message-ID: <xbgqegeqsobrkf32aepwwe3khhucebgjraorpstt5226pghadd@yx62fi2gdv2p>
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <20241228-sysfs-const-bin_attr-simple-v2-1-7c6f3f1767a3@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241228-sysfs-const-bin_attr-simple-v2-1-7c6f3f1767a3@weissschuh.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K0tCbzaFqk7BHIgLmM55l7I93y31a2B1
X-Proofpoint-ORIG-GUID: d1GjE4-ccz4lJkp22uUoE_W9nitpvG_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501020046

Looks good to me. Did boot test and reading the /sys files works.

Linux-ci tests [0] are also good (the failing tests are broken from
some time, ignoring them):

[0]: https://github.com/adi-g15-ibm/linux-ci/actions?query=branch%3Atmp-test-branch-10962+branch%3Atmp-test-branch-26310+branch%3Atmp-test-branch-23431++

Tested-by: Aditya Gupta <adityagupta@ibm.com>

Thanks,
- Aditya G

On 24/12/28 09:43AM, Thomas Weißschuh wrote:
> Most users use this function through the BIN_ATTR_SIMPLE* macros,
> they can handle the switch transparently.
> Also adapt the two non-macro users in the same change.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 2 +-
>  fs/sysfs/file.c                       | 2 +-
>  include/linux/sysfs.h                 | 4 ++--
>  kernel/module/sysfs.c                 | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
> index 5d0f35bb917ebced8c741cd3af2c511949a1d2ef..013637e2b2a8e6a4ec6b93a520f8d5d9d3245467 100644
> --- a/arch/powerpc/platforms/powernv/opal.c
> +++ b/arch/powerpc/platforms/powernv/opal.c
> @@ -818,7 +818,7 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
>  	sysfs_bin_attr_init(attr);
>  	attr->attr.name = name;
>  	attr->attr.mode = 0400;
> -	attr->read = sysfs_bin_attr_simple_read;
> +	attr->read_new = sysfs_bin_attr_simple_read;
>  	attr->private = __va(vals[0]);
>  	attr->size = vals[1];
>  
> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
> index 785408861c01c89fc84c787848243a13c1338367..6931308876c4ac3b4c19878d5e1158ad8fe4f16f 100644
> --- a/fs/sysfs/file.c
> +++ b/fs/sysfs/file.c
> @@ -817,7 +817,7 @@ EXPORT_SYMBOL_GPL(sysfs_emit_at);
>   * Returns number of bytes written to @buf.
>   */
>  ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
> -				   struct bin_attribute *attr, char *buf,
> +				   const struct bin_attribute *attr, char *buf,
>  				   loff_t off, size_t count)
>  {
>  	memcpy(buf, attr->private + off, count);
> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
> index 0f2fcd244523f050c5286f19d4fe1846506f9214..2205561159afdb57d0a250bb0439b28c01d9010e 100644
> --- a/include/linux/sysfs.h
> +++ b/include/linux/sysfs.h
> @@ -511,7 +511,7 @@ __printf(3, 4)
>  int sysfs_emit_at(char *buf, int at, const char *fmt, ...);
>  
>  ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
> -				   struct bin_attribute *attr, char *buf,
> +				   const struct bin_attribute *attr, char *buf,
>  				   loff_t off, size_t count);
>  
>  #else /* CONFIG_SYSFS */
> @@ -774,7 +774,7 @@ static inline int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
>  
>  static inline ssize_t sysfs_bin_attr_simple_read(struct file *file,
>  						 struct kobject *kobj,
> -						 struct bin_attribute *attr,
> +						 const struct bin_attribute *attr,
>  						 char *buf, loff_t off,
>  						 size_t count)
>  {
> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
> index 456358e1fdc43e6b5b24f383bbefa37812971174..254017b58b645d4afcf6876d29bcc2e2113a8dc4 100644
> --- a/kernel/module/sysfs.c
> +++ b/kernel/module/sysfs.c
> @@ -196,7 +196,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>  			nattr->attr.mode = 0444;
>  			nattr->size = info->sechdrs[i].sh_size;
>  			nattr->private = (void *)info->sechdrs[i].sh_addr;
> -			nattr->read = sysfs_bin_attr_simple_read;
> +			nattr->read_new = sysfs_bin_attr_simple_read;
>  			++nattr;
>  		}
>  		++loaded;
> 
> -- 
> 2.47.1
> 


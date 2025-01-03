Return-Path: <bpf+bounces-47827-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C9DA00650
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 09:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 045D11634A2
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 08:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC731CD210;
	Fri,  3 Jan 2025 08:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X117eB7C"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625181940B1;
	Fri,  3 Jan 2025 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735894613; cv=none; b=KwoV31SiO3h+DIdPUV+ewYbhYS8myYP21GSY11fZCc0MOpwdgjDTkZ+RMx7B5+bATPrpThuUfwgRzVamOIIVJmktjEt+49dWS7epXImtyySoYi9N3cNijSd6dYhElcfa3Fs8Lc2h7Tz1c7OxyghwjZtBP12GXF12TkfOvmF7jyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735894613; c=relaxed/simple;
	bh=7Ss2tdLw4JYGn715IrB5t0jg2EMHFGEGprdpzEJVU9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gyjcHa3aPs9e36zx3jqgXo3zPlJWDDpK8SsVjy1+7mcj9XqlM5kfGWq/ZnR1762vhBntUCkxJjqm2ETbv/4l+2j10asFuEraAUh83VRUAOrrmKzvhzB92msrIbfB5hvC9SIh0IilWSArDfcWh/MC3bUB60qQsApQiyrV418AFwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X117eB7C; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50385jdP003689;
	Fri, 3 Jan 2025 08:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=s5va7eFiA9dG7vhU6jSc3zqR8LZhCiejq3E0UYp0dWk=; b=X117eB7CXD4B
	jD00+cvGVsHeQOimiGneESqDtsjCuZmuMi89n1wh8SGsB6L9Zp8hLmpL8NIP8Coq
	ZiJHvvqfubm5SzkuHBnk3+1dVJ/QlVzGJ5sfi8283+M4wirirkF/gyWy9UGjvraR
	5W1sAof5PZlFAcTPJKu5PI7PM/bL4kpEd7hPfqbH0f6afF6wVj98i5Bjmd/SwOfc
	C/5/gDxJqW+9T7B/wMW1EydKwMn1Bb0GP9YY97o0S4ZiHvzVkjdQI0SUiJgMIxNY
	rJ2g3MRQbATs1uhOuBqppyT3zhFl/IypKtfJVY8AX1M0SEe0d+FljlX/IUF2Hzb4
	iL44JrpJ6A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43xc32r5es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 08:56:00 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5038txHe006325;
	Fri, 3 Jan 2025 08:55:59 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43xc32r5en-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 08:55:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50352vJw014589;
	Fri, 3 Jan 2025 08:55:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43tunswsgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 03 Jan 2025 08:55:58 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5038tvwU12452120
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 Jan 2025 08:55:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 41FB920043;
	Fri,  3 Jan 2025 08:55:57 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02CB020040;
	Fri,  3 Jan 2025 08:55:52 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.113.191.13])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  3 Jan 2025 08:55:51 +0000 (GMT)
Date: Fri, 3 Jan 2025 14:25:41 +0530
From: Mahesh J Salgaonkar <mahesh@linux.ibm.com>
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
Message-ID: <jpu4rjggipafjlg67t6t6htpvmcg3xukmepldfzgglrgqnmwwp@m5ijtdihc37t>
Reply-To: mahesh@linux.ibm.com
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <20241228-sysfs-const-bin_attr-simple-v2-1-7c6f3f1767a3@weissschuh.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241228-sysfs-const-bin_attr-simple-v2-1-7c6f3f1767a3@weissschuh.net>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Nxm_m42Whr8-j5y42LFTPkwe2lks3Kqs
X-Proofpoint-ORIG-GUID: WxQvIOazIZSmyqH_ffQp36JLk5UoiDZp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=920 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501030073

On 2024-12-28 09:43:41 Sat, Thomas Weiﬂschuh wrote:
> Most users use this function through the BIN_ATTR_SIMPLE* macros,
> they can handle the switch transparently.
> Also adapt the two non-macro users in the same change.
> 
> Signed-off-by: Thomas Weiﬂschuh <linux@weissschuh.net>
> ---
>  arch/powerpc/platforms/powernv/opal.c | 2 +-
>  fs/sysfs/file.c                       | 2 +-
>  include/linux/sysfs.h                 | 4 ++--
>  kernel/module/sysfs.c                 | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)

Looks good to me.

Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Thanks,
-Mahesh.

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
> 

-- 
Mahesh J Salgaonkar


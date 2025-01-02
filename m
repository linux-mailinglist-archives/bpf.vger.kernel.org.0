Return-Path: <bpf+bounces-47742-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 466239FF659
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 06:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AC5D162130
	for <lists+bpf@lfdr.de>; Thu,  2 Jan 2025 05:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07046191489;
	Thu,  2 Jan 2025 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Pi3gg13b"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1169219FF;
	Thu,  2 Jan 2025 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735796519; cv=none; b=echK6QjEueFfWWGRmeB0KIHngGNMYDRiXWnO8a9dTdGjIRxxrZm2Emspmh8v5HkC1nwIlbJHpsyNsEoqBCHTWsESln4+WjfRa6qUlyj/Rvl2eOvqnkzJ3psqxaIj2hBMneFudUbuH1sGNHtyouOVILTUOnduUTxKdK5J4W24A0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735796519; c=relaxed/simple;
	bh=0Qk5iVj86usWKfYnfrfa6gBruV9NrvuhMBqUQH3mA4M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Sx/tOX9hPkXZtAjVQIwNvh4Z1SLDVc1zTX5N2F3srJCHt7iiZq5BfGHxhJKm+ZmPDZvRIzZbiKe6NYx6cNuB6rvLHeBSocd7sEE49aGucOGY2fqmHkhJ3bNbpRH5xwMcwTdPVsFzljDTSh7+yKGOZ2AhkC9PSVbA6FOUpAlpM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Pi3gg13b; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 501JtB2I011586;
	Thu, 2 Jan 2025 05:41:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=SDxj6Z
	RZpsE3FyDvmD4550kV1XKhjwzGx5jUxyVhJ3w=; b=Pi3gg13b/fQT1cuLh5tmSt
	5BFxL3I9aByc1kVxo1Z7bUXZQHF5bgGun+ObJGcNNkj1pEtpTf5PngfUGMd1YLkk
	yyMFFu60LIUxHgmOZVg4ocbRJkqVFXQH09TN6as4HlnXuJANis/1763QrVdj9n92
	oYpsehqxtIimLHo9hC0NHIVImpcjdZ1HSwlbu/AsPxL1XBByXD2BHr+rhj12ooaE
	s1zysMO2Y1xpQF08+RKXQtM0ywUDhEhxLgFIUBBiKH4LRDFAvE5Wv6loUH3b6gAm
	Tspkp5NVdH7gJzAZFltL/lqUvw+QNyURHgWErLniGKNczA5yWuffmrfFTCgZk8kw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43w7649xsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 05:41:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5025Zc76016587;
	Thu, 2 Jan 2025 05:41:22 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43w7649xst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 05:41:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50252Pvo004355;
	Thu, 2 Jan 2025 05:41:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43twvk0p5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 02 Jan 2025 05:41:21 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5025fHT556230172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 2 Jan 2025 05:41:18 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6DA92004B;
	Thu,  2 Jan 2025 05:41:17 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8664320040;
	Thu,  2 Jan 2025 05:41:13 +0000 (GMT)
Received: from [9.109.199.160] (unknown [9.109.199.160])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  2 Jan 2025 05:41:13 +0000 (GMT)
Message-ID: <283dd9ba-99ab-43d9-904a-efca1358cf06@linux.ibm.com>
Date: Thu, 2 Jan 2025 11:11:10 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] sysfs: constify bin_attribute argument of
 sysfs_bin_attr_simple_read()
From: Aditya Gupta <adityag@linux.ibm.com>
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin
 <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao <naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Luis Chamberlain
 <mcgrof@kernel.org>,
        Petr Pavlu <petr.pavlu@suse.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Daniel Gomez
 <da.gomez@samsung.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
        Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, bpf@vger.kernel.org
References: <20241228-sysfs-const-bin_attr-simple-v2-0-7c6f3f1767a3@weissschuh.net>
 <20241228-sysfs-const-bin_attr-simple-v2-1-7c6f3f1767a3@weissschuh.net>
 <xbgqegeqsobrkf32aepwwe3khhucebgjraorpstt5226pghadd@yx62fi2gdv2p>
Content-Language: en-US
In-Reply-To: <xbgqegeqsobrkf32aepwwe3khhucebgjraorpstt5226pghadd@yx62fi2gdv2p>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WtZIlJs1cezSxKdP-nJ8mwr-9fgi25s4
X-Proofpoint-ORIG-GUID: F5lb7f80hhitWxlXGZmJA_DhfqwgJMfO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 spamscore=0 mlxscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501020046

Hi,

Please use this Tested-by instead of the previous one i sent:

Tested-by: Aditya Gupta <adityag@linux.ibm.com>


Thanks,

- Aditya G

On 02/01/25 11:07, Aditya Gupta wrote:
> Looks good to me. Did boot test and reading the /sys files works.
>
> Linux-ci tests [0] are also good (the failing tests are broken from
> some time, ignoring them):
>
> [0]: https://github.com/adi-g15-ibm/linux-ci/actions?query=branch%3Atmp-test-branch-10962+branch%3Atmp-test-branch-26310+branch%3Atmp-test-branch-23431++
>
> Tested-by: Aditya Gupta <adityagupta@ibm.com>
>
> Thanks,
> - Aditya G
>
> On 24/12/28 09:43AM, Thomas Weißschuh wrote:
>> Most users use this function through the BIN_ATTR_SIMPLE* macros,
>> they can handle the switch transparently.
>> Also adapt the two non-macro users in the same change.
>>
>> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
>> ---
>>   arch/powerpc/platforms/powernv/opal.c | 2 +-
>>   fs/sysfs/file.c                       | 2 +-
>>   include/linux/sysfs.h                 | 4 ++--
>>   kernel/module/sysfs.c                 | 2 +-
>>   4 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/opal.c b/arch/powerpc/platforms/powernv/opal.c
>> index 5d0f35bb917ebced8c741cd3af2c511949a1d2ef..013637e2b2a8e6a4ec6b93a520f8d5d9d3245467 100644
>> --- a/arch/powerpc/platforms/powernv/opal.c
>> +++ b/arch/powerpc/platforms/powernv/opal.c
>> @@ -818,7 +818,7 @@ static int opal_add_one_export(struct kobject *parent, const char *export_name,
>>   	sysfs_bin_attr_init(attr);
>>   	attr->attr.name = name;
>>   	attr->attr.mode = 0400;
>> -	attr->read = sysfs_bin_attr_simple_read;
>> +	attr->read_new = sysfs_bin_attr_simple_read;
>>   	attr->private = __va(vals[0]);
>>   	attr->size = vals[1];
>>   
>> diff --git a/fs/sysfs/file.c b/fs/sysfs/file.c
>> index 785408861c01c89fc84c787848243a13c1338367..6931308876c4ac3b4c19878d5e1158ad8fe4f16f 100644
>> --- a/fs/sysfs/file.c
>> +++ b/fs/sysfs/file.c
>> @@ -817,7 +817,7 @@ EXPORT_SYMBOL_GPL(sysfs_emit_at);
>>    * Returns number of bytes written to @buf.
>>    */
>>   ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
>> -				   struct bin_attribute *attr, char *buf,
>> +				   const struct bin_attribute *attr, char *buf,
>>   				   loff_t off, size_t count)
>>   {
>>   	memcpy(buf, attr->private + off, count);
>> diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
>> index 0f2fcd244523f050c5286f19d4fe1846506f9214..2205561159afdb57d0a250bb0439b28c01d9010e 100644
>> --- a/include/linux/sysfs.h
>> +++ b/include/linux/sysfs.h
>> @@ -511,7 +511,7 @@ __printf(3, 4)
>>   int sysfs_emit_at(char *buf, int at, const char *fmt, ...);
>>   
>>   ssize_t sysfs_bin_attr_simple_read(struct file *file, struct kobject *kobj,
>> -				   struct bin_attribute *attr, char *buf,
>> +				   const struct bin_attribute *attr, char *buf,
>>   				   loff_t off, size_t count);
>>   
>>   #else /* CONFIG_SYSFS */
>> @@ -774,7 +774,7 @@ static inline int sysfs_emit_at(char *buf, int at, const char *fmt, ...)
>>   
>>   static inline ssize_t sysfs_bin_attr_simple_read(struct file *file,
>>   						 struct kobject *kobj,
>> -						 struct bin_attribute *attr,
>> +						 const struct bin_attribute *attr,
>>   						 char *buf, loff_t off,
>>   						 size_t count)
>>   {
>> diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
>> index 456358e1fdc43e6b5b24f383bbefa37812971174..254017b58b645d4afcf6876d29bcc2e2113a8dc4 100644
>> --- a/kernel/module/sysfs.c
>> +++ b/kernel/module/sysfs.c
>> @@ -196,7 +196,7 @@ static int add_notes_attrs(struct module *mod, const struct load_info *info)
>>   			nattr->attr.mode = 0444;
>>   			nattr->size = info->sechdrs[i].sh_size;
>>   			nattr->private = (void *)info->sechdrs[i].sh_addr;
>> -			nattr->read = sysfs_bin_attr_simple_read;
>> +			nattr->read_new = sysfs_bin_attr_simple_read;
>>   			++nattr;
>>   		}
>>   		++loaded;
>>
>> -- 
>> 2.47.1
>>


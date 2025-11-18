Return-Path: <bpf+bounces-74994-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B47DC6ADD8
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 18:14:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 386FE4F7DCC
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 17:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FB693A5E6A;
	Tue, 18 Nov 2025 17:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jii8NTfp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D463730CD;
	Tue, 18 Nov 2025 17:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485556; cv=none; b=SHiTa7Si9o5g1KgK0t3ueZsQD00GVX8zoDex9SKV1NS4U5Vb3bamM2XxfgY5y0UsuzrJlUG0PeM9mekmKWUmkuXhhWhOyRizVtdnJyXdrl0YXLMYmkhbMTmX55oZINo8NJVf5waFZXs5VCbhKXqo2iiDGWGpphazX8OviqoIwd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485556; c=relaxed/simple;
	bh=zGLhFS/DJsmiUGId4USkV4O5eUkaiKR1Zmk5ao6vY6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b01+K2amKLVHv4hKjKkMDISKqhMKccXczIOFl4/QHgi8oKuVpxj19VW2jaut4W7MsAOebrQmSpwFuIQ5M8w0dr83VKAxwEPi70Nax1O6FQDucuDaa6BrqRY4UsuVZdjP4TlKcibPQuhKgJ8ZKtG5TvPpi4W8wxY3AN1/nqIMclg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jii8NTfp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIFb44q028393;
	Tue, 18 Nov 2025 17:04:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ijA+HI
	YuNJYIZMsvTMim+FE9fA7c8Iz2SKyOURAWHGI=; b=jii8NTfp+CrLguiMc82UnJ
	a2AIDpJMZDmZjuML9w4Ac49hUCgw3CvbueuulWJImn1RwJDNvZNFxcVgCoUGPF5Q
	8Cf+BcS++w9IKJuAFc0lO5TvFVsedfK7XKOUfVVj7uYxIVobnNCtySaxgxpnr4KY
	amz6U5pt6Zf0U4OSU2uh7XbKfkX83NRfwHFcWkkgcOGqh/Gx9a/TjQbHsYmiu7wL
	+m5X2Acn+pWDELYlEPzBUo+0ENzk2K7SExETZ0Ct8yGWCt7LyU6pMc6/8OhgW2HB
	NVL/WRkS/b2rhhK1xGJ1YK8/EI/F4sncANiDxK1R5EWjcHuH0V4KbB1QxY58ZVMg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmskr23-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 17:04:34 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5AIGq5M7018669;
	Tue, 18 Nov 2025 17:04:33 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejmskr1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 17:04:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5AIFE2cV005137;
	Tue, 18 Nov 2025 17:04:32 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af5bk46qk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Nov 2025 17:04:32 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5AIH4Sx657409922
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 17:04:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 731132004D;
	Tue, 18 Nov 2025 17:04:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9933E2004B;
	Tue, 18 Nov 2025 17:04:27 +0000 (GMT)
Received: from [9.155.200.37] (unknown [9.155.200.37])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Nov 2025 17:04:27 +0000 (GMT)
Message-ID: <e5c5e17f-1efd-4f9e-be2d-c6f65003ba3d@linux.ibm.com>
Date: Tue, 18 Nov 2025 18:04:27 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 03/15] unwind_user/sframe: Add support for reading
 .sframe headers
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        bpf@vger.kernel.org, x86@kernel.org, linux-mm@kvack.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
References: <20251022144326.4082059-1-jremus@linux.ibm.com>
 <20251022144326.4082059-4-jremus@linux.ibm.com>
Content-Language: en-US
From: Jens Remus <jremus@linux.ibm.com>
Organization: IBM Deutschland Research & Development GmbH
In-Reply-To: <20251022144326.4082059-4-jremus@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: V9xFeZ-ISUTWS4Yz3HEfN4KzcAl4q8It
X-Authority-Analysis: v=2.4 cv=Rv3I7SmK c=1 sm=1 tr=0 ts=691ca722 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=5IsC6wTpv4i_iJZREhUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=DXsff8QfwkrTrK3sU8N1:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22
 a=bWyr8ysk75zN3GCy5bjg:22
X-Proofpoint-GUID: 4sK-gnDjYQrV3c78NwXR2VgwKDcxHk0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX00p+GvsXwWsL
 99UQLrEJdv/87Bi9UJUR/dzFbyC5q33Ywzwyelr5euiJ6eOjsZPGpV3i863qQ3mvTXK1pTP9omD
 88h2NYITEfIluJh0shbkujutN+JXsCUPRAAWQ+ksTE9OM0KocFKUEMfUFDudi98m1GuuXUmgoxC
 hNruG3iuHIVzjV/Uj6BPjATiIQXU4JaqBU1wDuE7NtGrjTBi6fixDiiUPPdm3GcyJvG6o2SSI/z
 0L1X1ejxZNmQI1oT677RzJ1dten6eO5QVp9NwKpQod5wB/k78SQOFbiqOwU8hqb3JL683ezSfmI
 HIEfiQ/Avvxc3odgSASGXHuox7weRkZXGEdQ/rsZxrXXu02Yi60E23ujRvt2Bcmf9J+jEjTNlSf
 /jDQJJefA9+M5jmGSO3/yqTPa2ATwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-18_02,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 spamscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

Hello Josh and Steven!

On 10/22/2025 4:43 PM, Jens Remus wrote:
> From: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> In preparation for unwinding user space stacks with sframe, add basic
> sframe compile infrastructure and support for reading the .sframe
> section header.
> 
> sframe_add_section() reads the header and unconditionally returns an
> error, so it's not very useful yet.  A subsequent patch will improve
> that.
> 
> Link: https://lore.kernel.org/all/f27e8463783febfa0dabb0432a3dd6be8ad98412.1737511963.git.jpoimboe@kernel.org/
> 
> [ Jens Remus: Add support for PC-relative FDE function start address. ]

I took a closer look and wondered whether some parts should better be
moved to subsequent patches.

> diff --git a/include/linux/sframe.h b/include/linux/sframe.h

> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_SFRAME_H
> +#define _LINUX_SFRAME_H
> +
> +#include <linux/mm_types.h>

Move to "[PATCH v11 04/15] unwind_user/sframe: Store sframe section data
in per-mm maple tree".

> +#include <linux/unwind_user_types.h>

Move to "[PATCH v11 06/15] unwind_user/sframe: Add support for reading
.sframe contents".  find_sframe() needs the types.

> +
> +#ifdef CONFIG_HAVE_UNWIND_USER_SFRAME
> +
> +struct sframe_section {
> +	unsigned long	sframe_start;
> +	unsigned long	sframe_end;
> +	unsigned long	text_start;
> +	unsigned long	text_end;
> +
> +	unsigned long	fdes_start;
> +	unsigned long	fres_start;
> +	unsigned long	fres_end;
> +	unsigned int	num_fdes;
> +
> +	signed char	ra_off;
> +	signed char	fp_off;
> +};
> +
> +extern int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
> +			      unsigned long text_start, unsigned long text_end);
> +extern int sframe_remove_section(unsigned long sframe_addr);
> +
> +#else /* !CONFIG_HAVE_UNWIND_USER_SFRAME */
> +
> +static inline int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
> +				     unsigned long text_start, unsigned long text_end)
> +{
> +	return -ENOSYS;
> +}
> +static inline int sframe_remove_section(unsigned long sframe_addr) { return -ENOSYS; }
> +
> +#endif /* CONFIG_HAVE_UNWIND_USER_SFRAME */
> +
> +#endif /* _LINUX_SFRAME_H */

> diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c

> @@ -0,0 +1,137 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Userspace sframe access functions
> + */
> +
> +#define pr_fmt(fmt)	"sframe: " fmt
> +
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/srcu.h>
> +#include <linux/uaccess.h>
> +#include <linux/mm.h>

Move to "[PATCH v11 04/15] unwind_user/sframe: Store sframe section data
in per-mm maple tree".

> +#include <linux/string_helpers.h>
> +#include <linux/sframe.h>
> +#include <linux/unwind_user_types.h>
> +
> +#include "sframe.h"
> +
> +#define dbg(fmt, ...)							\
> +	pr_debug("%s (%d): " fmt, current->comm, current->pid, ##__VA_ARGS__)
> +
> +static void free_section(struct sframe_section *sec)
> +{
> +	kfree(sec);
> +}
> +
> +static int sframe_read_header(struct sframe_section *sec)
> +{
> +	unsigned long header_end, fdes_start, fdes_end, fres_start, fres_end;
> +	struct sframe_header shdr;
> +	unsigned int num_fdes;
> +
> +	if (copy_from_user(&shdr, (void __user *)sec->sframe_start, sizeof(shdr))) {
> +		dbg("header usercopy failed\n");
> +		return -EFAULT;
> +	}
> +
> +	if (shdr.preamble.magic != SFRAME_MAGIC ||
> +	    shdr.preamble.version != SFRAME_VERSION_2 ||
> +	    !(shdr.preamble.flags & SFRAME_F_FDE_SORTED) ||
> +	    !(shdr.preamble.flags & SFRAME_F_FDE_FUNC_START_PCREL) ||
> +	    shdr.auxhdr_len) {
> +		dbg("bad/unsupported sframe header\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!shdr.num_fdes || !shdr.num_fres) {
> +		dbg("no fde/fre entries\n");
> +		return -EINVAL;
> +	}
> +
> +	header_end = sec->sframe_start + SFRAME_HEADER_SIZE(shdr);
> +	if (header_end >= sec->sframe_end) {
> +		dbg("header doesn't fit in section\n");
> +		return -EINVAL;
> +	}
> +
> +	num_fdes   = shdr.num_fdes;
> +	fdes_start = header_end + shdr.fdes_off;
> +	fdes_end   = fdes_start + (num_fdes * sizeof(struct sframe_fde));
> +
> +	fres_start = header_end + shdr.fres_off;
> +	fres_end   = fres_start + shdr.fre_len;
> +
> +	if (fres_start < fdes_end || fres_end > sec->sframe_end) {
> +		dbg("inconsistent fde/fre offsets\n");
> +		return -EINVAL;
> +	}
> +
> +	sec->num_fdes		= num_fdes;
> +	sec->fdes_start		= fdes_start;
> +	sec->fres_start		= fres_start;
> +	sec->fres_end		= fres_end;
> +
> +	sec->ra_off		= shdr.cfa_fixed_ra_offset;
> +	sec->fp_off		= shdr.cfa_fixed_fp_offset;
> +
> +	return 0;
> +}
> +
> +int sframe_add_section(unsigned long sframe_start, unsigned long sframe_end,
> +		       unsigned long text_start, unsigned long text_end)
> +{
> +	struct maple_tree *sframe_mt = &current->mm->sframe_mt;

Move to "[PATCH v11 04/15] unwind_user/sframe: Store sframe section data
in per-mm maple tree".

> +	struct vm_area_struct *sframe_vma, *text_vma;
> +	struct mm_struct *mm = current->mm;
> +	struct sframe_section *sec;
> +	int ret;
> +
> +	if (!sframe_start || !sframe_end || !text_start || !text_end) {
> +		dbg("zero-length sframe/text address\n");
> +		return -EINVAL;
> +	}
> +
> +	scoped_guard(mmap_read_lock, mm) {
> +		sframe_vma = vma_lookup(mm, sframe_start);
> +		if (!sframe_vma || sframe_end > sframe_vma->vm_end) {
> +			dbg("bad sframe address (0x%lx - 0x%lx)\n",
> +			    sframe_start, sframe_end);
> +			return -EINVAL;
> +		}
> +
> +		text_vma = vma_lookup(mm, text_start);
> +		if (!text_vma ||
> +		    !(text_vma->vm_flags & VM_EXEC) ||
> +		    text_end > text_vma->vm_end) {
> +			dbg("bad text address (0x%lx - 0x%lx)\n",
> +			    text_start, text_end);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	sec = kzalloc(sizeof(*sec), GFP_KERNEL);
> +	if (!sec)
> +		return -ENOMEM;
> +
> +	sec->sframe_start	= sframe_start;
> +	sec->sframe_end		= sframe_end;
> +	sec->text_start		= text_start;
> +	sec->text_end		= text_end;
> +
> +	ret = sframe_read_header(sec);
> +	if (ret)
> +		goto err_free;
> +
> +	/* TODO nowhere to store it yet - just free it and return an error */

An alternative would be to move sframe_add_section() to
"[PATCH v11 04/15] unwind_user/sframe: Store sframe section data in
per-mm maple tree" and reorder the patches as outlined below.

> +	ret = -ENOSYS;
> +
> +err_free:
> +	free_section(sec);
> +	return ret;
> +}
> +
> +int sframe_remove_section(unsigned long sframe_start)
> +{
> +	return -ENOSYS;
> +}

I wonder whether the series should be restructured as follows:

unwind_user/sframe: Store .sframe section data in per-mm maple tree
unwind_user/sframe: Detect .sframe sections in executables
unwind_user/sframe: Add support for reading .sframe headers
unwind_user/sframe: Add support for reading .sframe contents
unwind_user/sframe: Wire up unwind_user to sframe
x86/uaccess: Add unsafe_copy_from_user() implementation
unwind_user/sframe/x86: Enable sframe unwinding on x86
unwind_user: Stop when reaching an outermost frame
unwind_user/sframe: Add support for outermost frame indication
unwind_user/sframe: Remove .sframe section on detected corruption
unwind_user/sframe: Show file name in debug output
unwind_user/sframe: Add .sframe validation option
unwind_user/sframe: Add prctl() interface for registering .sframe sections

While moving sframe_add_section() and sframe_remove_section() from
"unwind_user/sframe: Add support for reading .sframe headers" to
"unwind_user/sframe: Store .sframe section data in per-mm maple tree" or
into a new second patch, as they depend on the first and are required
by the third.

What are your thoughts?  The reordering might be wasted effort.

Thanks and regards,
Jens
-- 
Jens Remus
Linux on Z Development (D3303)
+49-7031-16-1128 Office
jremus@de.ibm.com

IBM

IBM Deutschland Research & Development GmbH; Vorsitzender des Aufsichtsrats: Wolfgang Wendt; Geschäftsführung: David Faller; Sitz der Gesellschaft: Böblingen; Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM Data Privacy Statement: https://www.ibm.com/privacy/



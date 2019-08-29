Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A344A1422
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2019 10:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbfH2Iwm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Thu, 29 Aug 2019 04:52:42 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30066 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbfH2Iwm (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 29 Aug 2019 04:52:42 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7T8qARQ023678
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 04:52:41 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2up9s5bprr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2019 04:52:41 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <bpf@vger.kernel.org> from <iii@linux.ibm.com>;
        Thu, 29 Aug 2019 09:52:38 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 29 Aug 2019 09:52:35 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7T8qCa715794536
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Aug 2019 08:52:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 891A542045;
        Thu, 29 Aug 2019 08:52:34 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 51F844203F;
        Thu, 29 Aug 2019 08:52:34 +0000 (GMT)
Received: from dyn-9-152-98-121.boeblingen.de.ibm.com (unknown [9.152.98.121])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 29 Aug 2019 08:52:34 +0000 (GMT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [PATCH v3] bpf: s390: add JIT support for multi-function programs
From:   Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20190828182846.10473-1-yauheni.kaliuta@redhat.com>
Date:   Thu, 29 Aug 2019 10:52:33 +0200
Cc:     bpf@vger.kernel.org, daniel@iogearbox.net, jolsa@redhat.com
Content-Transfer-Encoding: 8BIT
References: <20190826182036.17456-1-yauheni.kaliuta@redhat.com>
 <20190828182846.10473-1-yauheni.kaliuta@redhat.com>
To:     Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
X-Mailer: Apple Mail (2.3445.9.1)
X-TM-AS-GCONF: 00
x-cbid: 19082908-0012-0000-0000-00000344304A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082908-0013-0000-0000-0000217E6FE6
Message-Id: <7B6D5C38-E394-4A77-81E4-161409A8357B@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-29_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=11 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908290098
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> Am 28.08.2019 um 20:28 schrieb Yauheni Kaliuta <yauheni.kaliuta@redhat.com>:
> 
> This adds support for bpf-to-bpf function calls in the s390 JIT
> compiler. The JIT compiler converts the bpf call instructions to
> native branch instructions. After a round of the usual passes, the
> start addresses of the JITed images for the callee functions are
> known. Finally, to fixup the branch target addresses, we need to
> perform an extra pass.
> 
> Because of the address range in which JITed images are allocated on
> s390, the offsets of the start addresses of these images from
> __bpf_call_base are as large as 64 bits. So, for a function call,
> the imm field of the instruction cannot be used to determine the
> callee's address. Use bpf_jit_get_func_addr() helper instead.
> 
> The patch borrows a lot from:
> 
> commit 8c11ea5ce13d ("bpf, arm64: fix getting subprog addr from aux
> for calls")
> 
> commit e2c95a61656d ("bpf, ppc64: generalize fetching subprog into
> bpf_jit_get_func_addr")
> 
> commit 8484ce8306f9 ("bpf: powerpc64: add JIT support for
> multi-function programs")
> 
> (including the commit message).
> 
> test_verifier (5.3-rc6 with CONFIG_BPF_JIT_ALWAYS_ON=y):
> 
> without patch:
> Summary: 1501 PASSED, 0 SKIPPED, 47 FAILED
> 
> with patch:
> Summary: 1540 PASSED, 0 SKIPPED, 8 FAILED
> 
> Signed-off-by: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
> ---
> arch/s390/net/bpf_jit_comp.c | 66 ++++++++++++++++++++++++++++++------
> 1 file changed, 55 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
> index 955eb355c2fd..b6801d854c77 100644
> --- a/arch/s390/net/bpf_jit_comp.c
> +++ b/arch/s390/net/bpf_jit_comp.c
> @@ -502,7 +502,8 @@ static void bpf_jit_epilogue(struct bpf_jit *jit, u32 stack_depth)
>  * NOTE: Use noinline because for gcov (-fprofile-arcs) gcc allocates a lot of
>  * stack space for the large switch statement.
>  */
> -static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i)
> +static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
> +				 int i, bool extra_pass)
> {
> 	struct bpf_insn *insn = &fp->insnsi[i];
> 	int jmp_off, last, insn_count = 1;
> @@ -1011,10 +1012,14 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
> 	 */
> 	case BPF_JMP | BPF_CALL:
> 	{
> -		/*
> -		 * b0 = (__bpf_call_base + imm)(b1, b2, b3, b4, b5)
> -		 */
> -		const u64 func = (u64)__bpf_call_base + imm;
> +		u64 func;
> +		bool func_addr_fixed;
> +		int ret;
> +
> +		ret = bpf_jit_get_func_addr(fp, insn, extra_pass,
> +					    &func, &func_addr_fixed);
> +		if (ret < 0)
> +			return -1;
> 
> 		REG_SET_SEEN(BPF_REG_5);
> 		jit->seen |= SEEN_FUNC;
> @@ -1283,7 +1288,8 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp, int i
> /*
>  * Compile eBPF program into s390x code
>  */
> -static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp)
> +static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp,
> +			bool extra_pass)
> {
> 	int i, insn_count;
> 
> @@ -1292,7 +1298,7 @@ static int bpf_jit_prog(struct bpf_jit *jit, struct bpf_prog *fp)
> 
> 	bpf_jit_prologue(jit, fp->aux->stack_depth);
> 	for (i = 0; i < fp->len; i += insn_count) {
> -		insn_count = bpf_jit_insn(jit, fp, i);
> +		insn_count = bpf_jit_insn(jit, fp, i, extra_pass);
> 		if (insn_count < 0)
> 			return -1;
> 		/* Next instruction address */
> @@ -1311,6 +1317,12 @@ bool bpf_jit_needs_zext(void)
> 	return true;
> }
> 
> +struct s390_jit_data {
> +	struct bpf_binary_header *header;
> +	struct bpf_jit ctx;
> +	int pass;
> +};
> +
> /*
>  * Compile eBPF program "fp"
>  */
> @@ -1318,7 +1330,9 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> {
> 	struct bpf_prog *tmp, *orig_fp = fp;
> 	struct bpf_binary_header *header;
> +	struct s390_jit_data *jit_data;
> 	bool tmp_blinded = false;
> +	bool extra_pass = false;
> 	struct bpf_jit jit;
> 	int pass;
> 
> @@ -1337,6 +1351,23 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> 		fp = tmp;
> 	}
> 
> +	jit_data = fp->aux->jit_data;
> +	if (!jit_data) {
> +		jit_data = kzalloc(sizeof(*jit_data), GFP_KERNEL);
> +		if (!jit_data) {
> +			fp = orig_fp;
> +			goto out;
> +		}
> +		fp->aux->jit_data = jit_data;
> +	}
> +	if (jit_data->ctx.addrs) {
> +		jit = jit_data->ctx;
> +		header = jit_data->header;
> +		extra_pass = true;
> +		pass = jit_data->pass + 1;
> +		goto skip_init_ctx;
> +	}
> +
> 	memset(&jit, 0, sizeof(jit));
> 	jit.addrs = kcalloc(fp->len + 1, sizeof(*jit.addrs), GFP_KERNEL);
> 	if (jit.addrs == NULL) {
> @@ -1349,7 +1380,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> 	 *   - 3:   Calculate program size and addrs arrray
> 	 */
> 	for (pass = 1; pass <= 3; pass++) {
> -		if (bpf_jit_prog(&jit, fp)) {
> +		if (bpf_jit_prog(&jit, fp, extra_pass)) {
> 			fp = orig_fp;
> 			goto free_addrs;
> 		}
> @@ -1361,12 +1392,14 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> 		fp = orig_fp;
> 		goto free_addrs;
> 	}
> +
> 	header = bpf_jit_binary_alloc(jit.size, &jit.prg_buf, 2, jit_fill_hole);
> 	if (!header) {
> 		fp = orig_fp;
> 		goto free_addrs;
> 	}
> -	if (bpf_jit_prog(&jit, fp)) {
> +skip_init_ctx:
> +	if (bpf_jit_prog(&jit, fp, extra_pass)) {
> 		bpf_jit_binary_free(header);
> 		fp = orig_fp;
> 		goto free_addrs;
> @@ -1375,12 +1408,23 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *fp)
> 		bpf_jit_dump(fp->len, jit.size, pass, jit.prg_buf);
> 		print_fn_code(jit.prg_buf, jit.size_prg);
> 	}
> -	bpf_jit_binary_lock_ro(header);
> +	if (!fp->is_func || extra_pass) {
> +		bpf_jit_binary_lock_ro(header);
> +	} else {
> +		jit_data->header = header;
> +		jit_data->ctx = jit;
> +		jit_data->pass = pass;
> +	}
> 	fp->bpf_func = (void *) jit.prg_buf;
> 	fp->jited = 1;
> 	fp->jited_len = jit.size;
> +
> +	if (!fp->is_func || extra_pass) {
> free_addrs:
> -	kfree(jit.addrs);
> +		kfree(jit.addrs);
> +		kfree(jit_data);
> +		fp->aux->jit_data = NULL;
> +	}
> out:
> 	if (tmp_blinded)
> 		bpf_jit_prog_release_other(fp, fp == orig_fp ?
> -- 
> 2.22.0

Thank you!

Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>

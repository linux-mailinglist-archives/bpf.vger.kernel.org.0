Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46E84F817A
	for <lists+bpf@lfdr.de>; Thu,  7 Apr 2022 16:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbiDGOV6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 7 Apr 2022 10:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiDGOV4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Apr 2022 10:21:56 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF361252A9
        for <bpf@vger.kernel.org>; Thu,  7 Apr 2022 07:19:55 -0700 (PDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 237E4AbU032701;
        Thu, 7 Apr 2022 14:19:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=ySUd/GZWtM8iOWsUzxj90+4VpAHePIYePQCyrdFw+IY=;
 b=dzHLr++e58H8YBsjmDXo2+a/Zlp7NVKbFyAORHjhFn1dElO8jXyGAYarKUBZ0CGVAF5j
 EYpcaKtmQFKZFMyVugIIqGuHYq7RSVEO3xF23lyM0XpsKpvw8+wKMSRqkwWzowO3MvhE
 WghC9pTHOrXrLtHM5GHUw09InMPNKtzxBiv3ZmniEUzi767So5is+X4PHeZSMi0AU8mR
 QCpa3M68STbPxh6xH9FUthrfYN7f2qGCAvo/PX3Rt4HAIz340oDE6Q0rplTptJJZcEDl
 6xD63mXYAwYTsq9f/xKem8iEo0GM3D70V3C7h6i7f765QNDzzb82mobdMbp+A51OwGBT IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa13y8vd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:19:39 +0000
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 237E4Ct2000498;
        Thu, 7 Apr 2022 14:19:38 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3fa13y8vcb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:19:38 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 237EJaoB004823;
        Thu, 7 Apr 2022 14:19:36 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma05fra.de.ibm.com with ESMTP id 3f6e48r9b0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 07 Apr 2022 14:19:36 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 237EJfLY44302718
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 7 Apr 2022 14:19:41 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EAD211C050;
        Thu,  7 Apr 2022 14:19:34 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F65111C04C;
        Thu,  7 Apr 2022 14:19:33 +0000 (GMT)
Received: from [9.171.82.41] (unknown [9.171.82.41])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  7 Apr 2022 14:19:33 +0000 (GMT)
Message-ID: <28c378a6eb72b66b44cfac250807a2a01ee478af.camel@linux.ibm.com>
Subject: Re: [PATCH v3 bpf-next 1/7] libbpf: add BPF-side of USDT support
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        ast@kernel.org, daniel@iogearbox.net
Cc:     kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Hengqi Chen <hengqi.chen@gmail.com>
Date:   Thu, 07 Apr 2022 16:19:33 +0200
In-Reply-To: <20220404234202.331384-2-andrii@kernel.org>
References: <20220404234202.331384-1-andrii@kernel.org>
         <20220404234202.331384-2-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s9VYrCAPyYSoNm3q5NdroBfdMva3WE6w
X-Proofpoint-GUID: EfMJAlJV0QLzkCFnhDKD3xKME_oZOR1w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-07_03,2022-04-07_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 malwarescore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204070065
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, 2022-04-04 at 16:41 -0700, Andrii Nakryiko wrote:
> Add BPF-side implementation of libbpf-provided USDT support. This
> consists of single header library, usdt.bpf.h, which is meant to be
> used
> from user's BPF-side source code. This header is added to the list of
> installed libbpf header, along bpf_helpers.h and others.
> 
> BPF-side implementation consists of two BPF maps:
>   - spec map, which contains "a USDT spec" which encodes information
>     necessary to be able to fetch USDT arguments and other
> information
>     (argument count, user-provided cookie value, etc) at runtime;
>   - IP-to-spec-ID map, which is only used on kernels that don't
> support
>     BPF cookie feature. It allows to lookup spec ID based on the
> place
>     in user application that triggers USDT program.
> 
> These maps have default sizes, 256 and 1024, which are chosen
> conservatively to not waste a lot of space, but handling a lot of
> common
> cases. But there could be cases when user application needs to either
> trace a lot of different USDTs, or USDTs are heavily inlined and
> their
> arguments are located in a lot of differing locations. For such cases
> it
> might be necessary to size those maps up, which libbpf allows to do
> by
> overriding BPF_USDT_MAX_SPEC_CNT and BPF_USDT_MAX_IP_CNT macros.
> 
> It is an important aspect to keep in mind. Single USDT (user-space
> equivalent of kernel tracepoint) can have multiple USDT "call sites".
> That is, single logical USDT is triggered from multiple places in
> user
> application. This can happen due to function inlining. Each such
> inlined
> instance of USDT invocation can have its own unique USDT argument
> specification (instructions about the location of the value of each
> of
> USDT arguments). So while USDT looks very similar to usual uprobe or
> kernel tracepoint, under the hood it's actually a collection of
> uprobes,
> each potentially needing different spec to know how to fetch
> arguments.
> 
> User-visible API consists of three helper functions:
>   - bpf_usdt_arg_cnt(), which returns number of arguments of current
> USDT;
>   - bpf_usdt_arg(), which reads value of specified USDT argument (by
>     it's zero-indexed position) and returns it as 64-bit value;
>   - bpf_usdt_cookie(), which functions like BPF cookie for USDT
>     programs; this is necessary as libbpf doesn't allow specifying
> actual
>     BPF cookie and utilizes it internally for USDT support
> implementation.
> 
> Each bpf_usdt_xxx() APIs expect struct pt_regs * context, passed into
> BPF program. On kernels that don't support BPF cookie it is used to
> fetch absolute IP address of the underlying uprobe.
> 
> usdt.bpf.h also provides BPF_USDT() macro, which functions like
> BPF_PROG() and BPF_KPROBE() and allows much more user-friendly way to
> get access to USDT arguments, if USDT definition is static and known
> to
> the user. It is expected that majority of use cases won't have to use
> bpf_usdt_arg_cnt() and bpf_usdt_arg() directly and BPF_USDT() will
> cover
> all their needs.
> 
> Last, usdt.bpf.h is utilizing BPF CO-RE for one single purpose: to
> detect kernel support for BPF cookie. If BPF CO-RE dependency is
> undesirable, user application can redefine BPF_USDT_HAS_BPF_COOKIE to
> either a boolean constant (or equivalently zero and non-zero), or
> even
> point it to its own .rodata variable that can be specified from
> user's
> application user-space code. It is important that
> BPF_USDT_HAS_BPF_COOKIE is known to BPF verifier as static value
> (thus
> .rodata and not just .data), as otherwise BPF code will still contain
> bpf_get_attach_cookie() BPF helper call and will fail validation at
> runtime, if not dead-code eliminated.
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  tools/lib/bpf/Makefile   |   2 +-
>  tools/lib/bpf/usdt.bpf.h | 256
> +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 257 insertions(+), 1 deletion(-)
>  create mode 100644 tools/lib/bpf/usdt.bpf.h

[...]

> diff --git a/tools/lib/bpf/usdt.bpf.h b/tools/lib/bpf/usdt.bpf.h
> new file mode 100644
> index 000000000000..60237acf6b02
> --- /dev/null
> +++ b/tools/lib/bpf/usdt.bpf.h
> @@ -0,0 +1,256 @@

[...]

> +/* Fetch USDT argument #*arg_num* (zero-indexed) and put its value
> into *res.
> + * Returns 0 on success; negative error, otherwise.
> + * On error *res is guaranteed to be set to zero.
> + */
> +static inline __noinline
> +int bpf_usdt_arg(struct pt_regs *ctx, __u64 arg_num, long *res)
> +{
> +       struct __bpf_usdt_spec *spec;
> +       struct __bpf_usdt_arg_spec *arg_spec;
> +       unsigned long val;
> +       int err, spec_id;
> +
> +       *res = 0;
> +
> +       spec_id = __bpf_usdt_spec_id(ctx);
> +       if (spec_id < 0)
> +               return -ESRCH;
> +
> +       spec = bpf_map_lookup_elem(&__bpf_usdt_specs, &spec_id);
> +       if (!spec)
> +               return -ESRCH;
> +
> +       if (arg_num >= BPF_USDT_MAX_ARG_CNT || arg_num >= spec-
> >arg_cnt)
> +               return -ENOENT;
> +
> +       arg_spec = &spec->args[arg_num];
> +       switch (arg_spec->arg_type) {
> +       case BPF_USDT_ARG_CONST:
> +               /* Arg is just a constant ("-4@$-9" in USDT arg
> spec).
> +                * value is recorded in arg_spec->val_off directly.
> +                */
> +               val = arg_spec->val_off;
> +               break;
> +       case BPF_USDT_ARG_REG:
> +               /* Arg is in a register (e.g, "8@%rax" in USDT arg
> spec),
> +                * so we read the contents of that register directly
> from
> +                * struct pt_regs. To keep things simple user-space
> parts
> +                * record offsetof(struct pt_regs, <regname>) in
> arg_spec->reg_off.
> +                */
> +               err = bpf_probe_read_kernel(&val, sizeof(val), (void
> *)ctx + arg_spec->reg_off);
> +               if (err)
> +                       return err;
> +               break;
> +       case BPF_USDT_ARG_REG_DEREF:
> +               /* Arg is in memory addressed by register, plus some
> offset
> +                * (e.g., "-4@-1204(%rbp)" in USDT arg spec).
> Register is
> +                * identified lik with BPF_USDT_ARG_REG case, and the
> offset
> +                * is in arg_spec->val_off. We first fetch register
> contents
> +                * from pt_regs, then do another user-space probe
> read to
> +                * fetch argument value itself.
> +                */
> +               err = bpf_probe_read_kernel(&val, sizeof(val), (void
> *)ctx + arg_spec->reg_off);
> +               if (err)
> +                       return err;
> +               err = bpf_probe_read_user(&val, sizeof(val), (void
> *)val + arg_spec->val_off);

Is there a reason we always read 8 bytes here?
What if the user is interested in the last byte of a page?

[...]

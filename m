Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B104AB1D9
	for <lists+bpf@lfdr.de>; Sun,  6 Feb 2022 20:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiBFT6M (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 6 Feb 2022 14:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiBFT6M (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 6 Feb 2022 14:58:12 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F3DC06173B
        for <bpf@vger.kernel.org>; Sun,  6 Feb 2022 11:58:08 -0800 (PST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 216EoJ4l030270;
        Sun, 6 Feb 2022 19:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=gku3mP8mPtHIZ5Ca9tPRGib2xtMnT4HuAzPvT3lF4kQ=;
 b=ryGzE4BciAhKsiV1y9x2Xa5WeGb4ql+OL6sBLhfmKfJPhwJPol+YnREPKq7KotdNoG7M
 Tzuhe+hLl3aV1aZhnF6T+6Y+cDgBboHjjTOYpHeUqWegv7ChSnTN+iSPGzLJLUMtCxIm
 UbmleT6p6+4CmOKacGCu4QVkGZG4c9ZHAyUxfnA7MnN1MBNF6Gu7wuYaK44aXBIthn5n
 Xl0dipxxovuix/v+AxIiM2wT5XtRDG2IHIjCL7E3nxz/G7nz0350GqkIOTTH3oohZrVJ
 vsoewm72wiwTFBGoJBVj8pPRN/e8SfOyJOB8FVF5P5uVgoak0Su+OWeKFacWmWIRQ++x 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22ssc717-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 19:57:29 +0000
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 216JvTE1017016;
        Sun, 6 Feb 2022 19:57:29 GMT
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e22ssc70x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 19:57:29 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 216JqUcN014351;
        Sun, 6 Feb 2022 19:57:26 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 3e1gv8xa10-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Feb 2022 19:57:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 216JvKro33161710
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Feb 2022 19:57:20 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D211DA4051;
        Sun,  6 Feb 2022 19:57:20 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 60593A404D;
        Sun,  6 Feb 2022 19:57:20 +0000 (GMT)
Received: from [9.171.78.41] (unknown [9.171.78.41])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  6 Feb 2022 19:57:20 +0000 (GMT)
Message-ID: <5e4b012be25cbbb44ecb935de745e17ed5c16f28.camel@linux.ibm.com>
Subject: Re: [PATCH bpf-next 0/2] Fix bpf_perf_event_data ABI breakage
From:   Ilya Leoshkevich <iii@linux.ibm.com>
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        bpf <bpf@vger.kernel.org>
Date:   Sun, 06 Feb 2022 20:57:20 +0100
In-Reply-To: <CAEf4Bzb1To5+uLdRiJEJUJo4PckVDEBEtENC14Cuf-mkxrnxgA@mail.gmail.com>
References: <20220206145350.2069779-1-iii@linux.ibm.com>
         <CAEf4Bzb1To5+uLdRiJEJUJo4PckVDEBEtENC14Cuf-mkxrnxgA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 69mWgN38eTk4chGTt90fyal6oh24m5KO
X-Proofpoint-ORIG-GUID: rXYWFHuziCPhmfZBvxulQ5lAQkTl-DYm
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-06_05,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202060142
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, 2022-02-06 at 11:31 -0800, Andrii Nakryiko wrote:
> On Sun, Feb 6, 2022 at 6:54 AM Ilya Leoshkevich <iii@linux.ibm.com>
> wrote:
> > 
> > libbpf CI noticed that my recent changes broke bpf_perf_event_data
> > ABI
> > on s390 [1]. Testing shows that they introduced a similar breakage
> > on
> > arm64. The problem is that we are not allowed to extend
> > user_pt_regs,
> > since it's used by bpf_perf_event_data.
> > 
> > This series fixes these problems by removing the new members and
> > introducing user_pt_regs_v2 instead.
> > 
> > [1] https://github.com/libbpf/libbpf/runs/5079938810
> > 
> > Ilya Leoshkevich (2):
> >   s390/bpf: Introduce user_pt_regs_v2
> >   arm64/bpf: Introduce struct user_pt_regs_v2
> 
> Given it is bpf_perf_event_data and thus bpf_user_pt_regs_t
> definitions that are set in stone now, wouldn't it be better to
> instead just change
> 
> typedef user_pt_regs bpf_user_pt_regs_t; (s390x)
> typedef struct user_pt_regs bpf_user_pt_regs_t; (arm64)
> 
> to just define that fixed layout instead of reusing user_ptr_regs?
> 
> This whole v2 business looks really ugly.

Wouldn't it break compilation of code like this?

    bpf_perf_event_data data;
    user_pt_regs *regs = &data.regs;

Additionaly, after this I'm no longer sure I haven't missed any other
places where user_pt_regs might be used. For example, arm64 seems to be
using it not only for BPF, but also for ptrace?

static int gpr_get(struct task_struct *target,
                   const struct user_regset *regset,
                   struct membuf to)
{
        struct user_pt_regs *uregs = &task_pt_regs(target)->user_regs;
        return membuf_write(&to, uregs, sizeof(*uregs));
}

and then in e.g. gdb:

static void
aarch64_fill_gregset (struct regcache *regcache, void *buf)
{
  struct user_pt_regs *regset = (struct user_pt_regs *) buf;
  ...

I'm also not a big fan of the _v2 solution, but it looked the safest
to me. At least for s390, a viable alternative that Vasily proposed
would be to go ahead with replacing args[1] with orig_gpr2 and then
also backporting the patch, so that the new libbpf would still work on
the old stable kernels. But this won't work for arm64.

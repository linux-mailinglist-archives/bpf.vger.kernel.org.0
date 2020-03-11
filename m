Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E7CB181787
	for <lists+bpf@lfdr.de>; Wed, 11 Mar 2020 13:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729206AbgCKMKL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Mar 2020 08:10:11 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52768 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729026AbgCKMKL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Mar 2020 08:10:11 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BC4eEp019913;
        Wed, 11 Mar 2020 12:10:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2020-01-29;
 bh=waOvXzN7lsgmvBnWbqSJ6hX9bN7Yp5e/lFbytaAHsjo=;
 b=BqALzlMXqfZlmAMPysrl4/Vhnfv+Ja2vUFwtZCn2ZhlB+TzOOwta1GtD2wVmQSDC8eE5
 7N3clezXCYP/42fqjxsiRUFea8DcNAVzaBLn/NSwrV+x42m1jEnzv7KNSxLFLut8+Sih
 B/doF+7bWW8fDFyV0be+9ita/NOM+LV1+EBPLkLvE74n5WpJmCNrh5JdXvWS8aftZDGh
 Uc/jvSxO9oI8DaNjoGrg9zcwUAQI93F1iJqOnal4shX+S+ah5VeAtaJRwbYmp1wMfYZn
 f/N1Y02hICzaAzcRN6GmLOViYRSasCgf9zcP/mNekroBdQA93B7HsnvY0TQK47kzpoJb 6A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2ym31uk5g2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 12:10:09 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02BC2pfs072903;
        Wed, 11 Mar 2020 12:10:08 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2yp8p2g262-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 11 Mar 2020 12:10:08 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02BCA76S016535;
        Wed, 11 Mar 2020 12:10:07 GMT
Received: from mwanda (/41.57.98.10)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Mar 2020 05:10:07 -0700
Date:   Wed, 11 Mar 2020 15:10:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     ast@kernel.org
Cc:     bpf@vger.kernel.org
Subject: [bug report] bpf: Support attaching tracing BPF program to other BPF
 programs
Message-ID: <20200311121001.GA20472@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 malwarescore=0 adultscore=0 suspectscore=1 mlxlogscore=978
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110078
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9556 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=1
 phishscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003110078
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello Alexei Starovoitov,

This is a semi-automatic email about new static checker warnings.

The patch 5b92a28aae4d: "bpf: Support attaching tracing BPF program
to other BPF programs" from Nov 14, 2019, leads to the following
Smatch complaint:

    kernel/bpf/btf.c:3744 btf_ctx_access()
    error: we previously assumed 't' could be null (see line 3706)

kernel/bpf/btf.c
  3705		/* if (t == NULL) Fall back to default BPF prog with 5 u64 arguments */
  3706		nr_args = t ? btf_type_vlen(t) : 5;
                          ^
Check

  3707		if (prog->aux->attach_btf_trace) {
  3708			/* skip first 'void *__data' argument in btf_trace_##name typedef */
  3709			args++;
  3710			nr_args--;
  3711		}
  3712	
  3713		if (arg == nr_args) {
  3714			if (prog->expected_attach_type == BPF_TRACE_FEXIT) {
  3715				if (!t)
  3716					return true;
  3717				t = btf_type_by_id(btf, t->type);
  3718			} else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
  3719				/* For now the BPF_MODIFY_RETURN can only be attached to
  3720				 * functions that return an int.
  3721				 */
  3722				if (!t)
  3723					return false;
  3724	
  3725				t = btf_type_skip_modifiers(btf, t->type, NULL);
  3726				if (!btf_type_is_int(t)) {
  3727					bpf_log(log,
  3728						"ret type %s not allowed for fmod_ret\n",
  3729						btf_kind_str[BTF_INFO_KIND(t->info)]);
  3730					return false;
  3731				}
  3732			}

Smatch is complaining that maybe t is NULL and prog->expected_attach_type
is neither BPF_TRACE_FEXIT nor BPF_MODIFY_RETURN.

  3733		} else if (arg >= nr_args) {
  3734			bpf_log(log, "func '%s' doesn't have %d-th argument\n",
  3735				tname, arg + 1);
  3736			return false;
  3737		} else {
  3738			if (!t)
  3739				/* Default prog with 5 args */
  3740				return true;
  3741			t = btf_type_by_id(btf, args[arg].type);
  3742		}
  3743		/* skip modifiers */
  3744		while (btf_type_is_modifier(t))
                                            ^
Dereference

  3745			t = btf_type_by_id(btf, t->type);
  3746		if (btf_type_is_int(t) || btf_type_is_enum(t))

regards,
dan carpenter

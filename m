Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99BCF3CCCE3
	for <lists+bpf@lfdr.de>; Mon, 19 Jul 2021 06:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhGSEOV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Jul 2021 00:14:21 -0400
Received: from out0.migadu.com ([94.23.1.103]:57585 "EHLO out0.migadu.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229512AbhGSEOV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Jul 2021 00:14:21 -0400
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1626667876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X887XloIo9SII0WY1sOK9vWk+QX7vdRRNpkirRR+QVw=;
        b=pF5jcvo+c40T8+T/8AZ/MvAHyXizo84Td/QLI68OkGmKpgttDzKgU9O7y9dC1DW1TvqT2+
        Kw9yf5Dqb+n2ouGckREsXVhZRpz8ZkOEUB+n67nG26biBwb2uhGaqOc8q93mFqxL3FK1cT
        RBSmg0BHVeOxeEnzLQFMpQdXy8UIyNM=
Date:   Mon, 19 Jul 2021 04:11:15 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   yajun.deng@linux.dev
Message-ID: <01896ade8ce4ad062de5cb63a1d09707@linux.dev>
Subject: Re: bpf selftest tc_bpf failed with latest bpf-next
To:     "Yonghong Song" <yhs@fb.com>, "bpf" <bpf@vger.kernel.org>,
        "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <536141f3-f76a-67d7-a081-c518919efd05@fb.com>
References: <536141f3-f76a-67d7-a081-c518919efd05@fb.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: yajun.deng@linux.dev
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

July 19, 2021 3:29 AM, "Yonghong Song" <yhs@fb.com> wrote:=0A=0A> The bpf=
 selftest tc_bpf failed with latest bpf-next. The following is the comman=
d to run and the=0A> result:=0A> =0A> $ ./test_progs -n 132=0A> [ 40.9475=
71] bpf_testmod: loading out-of-tree module taints kernel.=0A> test_tc_bp=
f:PASS:test_tc_bpf__open_and_load 0 nsec=0A> test_tc_bpf:PASS:bpf_tc_hook=
_create(BPF_TC_INGRESS) 0 nsec=0A> test_tc_bpf:PASS:bpf_tc_hook_create in=
valid hook.attach_point 0 nsec=0A> test_tc_bpf_basic:PASS:bpf_obj_get_inf=
o_by_fd 0 nsec=0A> test_tc_bpf_basic:PASS:bpf_tc_attach 0 nsec=0A> test_t=
c_bpf_basic:PASS:handle set 0 nsec=0A> test_tc_bpf_basic:PASS:priority se=
t 0 nsec=0A> test_tc_bpf_basic:PASS:prog_id set 0 nsec=0A> test_tc_bpf_ba=
sic:PASS:bpf_tc_attach replace mode 0 nsec=0A> test_tc_bpf_basic:PASS:bpf=
_tc_query 0 nsec=0A> test_tc_bpf_basic:PASS:handle set 0 nsec=0A> test_tc=
_bpf_basic:PASS:priority set 0 nsec=0A> test_tc_bpf_basic:PASS:prog_id se=
t 0 nsec=0A> libbpf: Kernel error message: Failed to send filter delete n=
otification=0A> test_tc_bpf_basic:FAIL:bpf_tc_detach unexpected error: -3=
 (errno 3)=0A> test_tc_bpf:FAIL:test_tc_internal ingress unexpected error=
: -3 (errno 3)=0A> #132 tc_bpf:FAIL=0A> =0A> The failure seems due to the=
 commit=0A> cfdf0d9ae75b ("rtnetlink: use nlmsg_notify() in rtnetlink_sen=
d()")=0A> =0A> Without the above commit, rtnetlink_send() will return 0 e=
ven if=0A> netlink_broadcast() (called by rtnetlink_send())=0A> returns a=
n error. The above commit makes it return=0A> an error code if netlink_br=
oadcast() failed.=0A> =0A> Such a rtnetlink_send() return value change im=
pacted the return value=0A> for tfilter_del_notify(), in sched/cls_api.c,=
 in the above test.=0A> Previously return 0, now return -3 (-ESRCH), caus=
ing the test failure.=0A> =0A> I am not sure what is the proper solution =
to address this.=0A> Should we just adjust test, or kernel change is also=
 needed?=0A=0AThanks report that, I'll route a patch to fix this in next =
submit.=0A> =0A> Kumar, Yajun, could you take a look?

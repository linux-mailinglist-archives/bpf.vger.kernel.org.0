Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38CC48E104
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 00:37:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235631AbiAMXhR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Jan 2022 18:37:17 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:40914 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232009AbiAMXhR (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 13 Jan 2022 18:37:17 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20DN7A4w026071
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 15:37:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qM3W7m1sG4QADw1qKcJ1ZsA48Yyz+W1BxIIMuja8xd8=;
 b=kHgQHiWviCKK+KuN3wVzxNdO9e3viJPvYpV6r/yXMDQFOTJhvsfdXwnmJsPHyxaFiPmH
 PWCTHMKF+j1xZ5beWtmzccKbFtFzR9Uc5qJ2OWDFIzp/Vprk9Y5Le0zuePAIdsjVLXqD
 7fD04KRrpQ1M5X5X6dtLwpCo74pW/eFNNh8= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3djh92vnxx-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Thu, 13 Jan 2022 15:37:16 -0800
Received: from twshared22811.39.frc1.facebook.com (2620:10d:c085:208::11) by
 mail.thefacebook.com (2620:10d:c085:11d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 13 Jan 2022 15:37:15 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id CE6F98F9838B; Thu, 13 Jan 2022 15:37:10 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <phoenix1987@gmail.com>
CC:     <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <yhs@fb.com>, Kenny Yu <kennyyu@fb.com>
Subject: Re: Proposal: bpf_copy_from_user_remote
Date:   Thu, 13 Jan 2022 15:37:08 -0800
Message-ID: <20220113233708.1682225-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAGnuNNtdvbk+wp8uYDPK3weGm5PVmM7hqEaD=Mg2nBT-dKtNHw@mail.gmail.com>
References: <CAGnuNNtdvbk+wp8uYDPK3weGm5PVmM7hqEaD=Mg2nBT-dKtNHw@mail.gmail.com>
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: MvCH3AGIdG5GuE3Kjn60Bi5hzjs0Maz2
X-Proofpoint-GUID: MvCH3AGIdG5GuE3Kjn60Bi5hzjs0Maz2
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_10,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxscore=0
 malwarescore=0 clxscore=1015 phishscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=514 spamscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130140
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Gabriele,

I just submitted a patch series that adds a similar helper to read
userspace memory from a remote process, please see: https://lore.kernel.org=
/bpf/20220113233158.1582743-1-kennyyu@fb.com/T/#ma0646f96bccf0b957793054de7=
404115d321079d

In my patch series, I added a bpf helper to wrap `access_process_vm`
which takes a `struct task_struct` argument instead of a pid.

In your patch series, one issue would be it is not clear which pid namespace
the pid belongs to, whereas passing a `struct task_struct` is unambiguous.
I think the helper signature in my patch series also provides more flexibil=
ity,
as the bpf program can also provide different flags on how to read
userspace memory.

Our use case at Meta for this change is to use a bpf task iterator program
to read debug information from a running process in production, e.g.,
extract C++ async stack traces from a running program.

A few questions:
* What is your use case for adding this helper?
* Do you have a specific requirement that requires using a pid, or would a
  helper using `struct task_struct` be sufficient?
* Are you ok with these changes? If so, I will proceed with my patch series.

Thanks,
Kenny Yu

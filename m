Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF17D48F262
	for <lists+bpf@lfdr.de>; Fri, 14 Jan 2022 23:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbiANWZH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 14 Jan 2022 17:25:07 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:10910 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230081AbiANWZH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 14 Jan 2022 17:25:07 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20EMNr9A028036
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 14:25:06 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=IEGTdGU+n3wkZ7Tz68UtMVyaSC5LxL+eOneT/Rv+5+8=;
 b=hJ7gw7FxfF4XfS9HlyID1Ay3mgTiqN9VTyMJnZwlLF3NM40evm/yOeuu4Hb5zT9Rd8fL
 O1sYw5Nh6yrE7oGCnTLqh0d1erNXqXbEBAkIpDgfFVMon+YlaDkLdz5KjA7BWoUFN0+B
 N7kVql3o9uLpqF+k0Mili+dibZG1ArTUswg= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3djxytwvwb-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Fri, 14 Jan 2022 14:25:06 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::f) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 14 Jan 2022 14:25:06 -0800
Received: by devbig014.vll3.facebook.com (Postfix, from userid 7377)
        id C0B119066BBA; Fri, 14 Jan 2022 14:24:58 -0800 (PST)
From:   Kenny Yu <kennyyu@fb.com>
To:     <phoenix1987@gmail.com>
CC:     <ast@kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
        <kennyyu@fb.com>, <yhs@fb.com>
Subject: Re: Proposal: bpf_copy_from_user_remote
Date:   Fri, 14 Jan 2022 14:24:47 -0800
Message-ID: <20220114222447.1642516-1-kennyyu@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAGnuNNvgtfBtU5d2FJ9qhjRCQpZTTq7gibgQntt7+SUstn6VKA@mail.gmail.com>
References: <CAGnuNNvgtfBtU5d2FJ9qhjRCQpZTTq7gibgQntt7+SUstn6VKA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: jr5HRy5A812KJ4nx3CovNu-P1nFL8_e8
X-Proofpoint-ORIG-GUID: jr5HRy5A812KJ4nx3CovNu-P1nFL8_e8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-14_06,2022-01-14_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 mlxlogscore=671
 bulkscore=0 malwarescore=0 clxscore=1015 impostorscore=0 mlxscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0
 adultscore=4 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2201140125
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Gabriele,

Thanks for the context about your use case!

> I don't expect to be needing to iterate over all running tasks, so as
long as the new helper can be used against specific processes that can
be identified via pid (and namespace) then I'm totally fine with your
patch series.

Sounds great! I'll proceed with my patch series based on `access_process_=
vm`.

> I switched to access_process_vm (but kept my signature) and got
something that works as intended for my use.

Awesome!

Thanks,
Kenny

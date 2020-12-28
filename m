Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68B572E6A02
	for <lists+bpf@lfdr.de>; Mon, 28 Dec 2020 19:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgL1Sax (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Dec 2020 13:30:53 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:16982 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727255AbgL1Sax (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Dec 2020 13:30:53 -0500
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BSIF3K6019572
        for <bpf@vger.kernel.org>; Mon, 28 Dec 2020 10:30:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=I+nnTaPCI74GsbKLUhjPMbaQ54u6cT0LHffjDy8iLvw=;
 b=TYW2gSQamlBU6soUnbqbmNZgvabbXs5RTwnYtMlCQXU1y57hM+AXeRYISTap0ygNFpSf
 yzrgulXsBib7vbdUA5rqfOanREg8OJ3uRdnVf9/6FyJKWud9S9YRYlGvc3lv419CkYZQ
 ghDbUhGmGXuSC+D6tS/qvwLc2ZW0ZSJwNiU= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35pp3vmj5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Mon, 28 Dec 2020 10:30:12 -0800
Received: from intmgw002.03.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 28 Dec 2020 10:30:12 -0800
Received: by devbig006.ftw2.facebook.com (Postfix, from userid 4523)
        id 5416362E2E12; Mon, 28 Dec 2020 10:30:11 -0800 (PST)
From:   Song Liu <songliubraving@fb.com>
To:     <bpf@vger.kernel.org>, Leah Neukirchen <leah@vuxu.org>
CC:     Song Liu <songliubraving@fb.com>
Subject: Re: [PATCH] bpf: Remove unnecessary <argp.h> include from  preload/iterators
Date:   Mon, 28 Dec 2020 10:29:57 -0800
Message-ID: <20201228182957.1122078-1-songliubraving@fb.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20201216100306.30942-1-leah@vuxu.org>
References: <20201216100306.30942-1-leah@vuxu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-28_17:2020-12-28,2020-12-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 phishscore=0 mlxlogscore=644
 lowpriorityscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012280113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Acked-by: Song Liu <songliubraving@fb.com>

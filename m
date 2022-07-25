Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08457F9EC
	for <lists+bpf@lfdr.de>; Mon, 25 Jul 2022 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbiGYHKe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 25 Jul 2022 03:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232137AbiGYHKc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Jul 2022 03:10:32 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 245DCA18C
        for <bpf@vger.kernel.org>; Mon, 25 Jul 2022 00:10:29 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lrrfg1h9Bz67Xcd;
        Mon, 25 Jul 2022 15:05:47 +0800 (CST)
Received: from fraeml714-chm.china.huawei.com (10.206.15.33) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 25 Jul 2022 09:10:26 +0200
Received: from fraeml714-chm.china.huawei.com ([10.206.15.33]) by
 fraeml714-chm.china.huawei.com ([10.206.15.33]) with mapi id 15.01.2375.024;
 Mon, 25 Jul 2022 09:10:26 +0200
From:   Roberto Sassu <roberto.sassu@huawei.com>
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
CC:     "quentin@isovalent.com" <quentin@isovalent.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "jevburton.kernel@gmail.com" <jevburton.kernel@gmail.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: RE: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr field
 for bpf_*_get_fd_by_id() funcs
Thread-Topic: [RFC][PATCH v3 02/15] bpf: Set open_flags as last bpf_attr field
 for bpf_*_get_fd_by_id() funcs
Thread-Index: AQHYne8hPBc0wtMTI0aMw6b0/5e6fq2Kiw4AgAQjoRA=
Date:   Mon, 25 Jul 2022 07:10:26 +0000
Message-ID: <5c5cdf397a6e4523845d0a16117e3b81@huawei.com>
References: <20220722171836.2852247-1-roberto.sassu@huawei.com>
 <20220722171836.2852247-3-roberto.sassu@huawei.com>
 <20220722175528.26ve4ahnir6su5tu@macbook-pro-3.dhcp.thefacebook.com>
In-Reply-To: <20220722175528.26ve4ahnir6su5tu@macbook-pro-3.dhcp.thefacebook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.221.98.153]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

> From: Alexei Starovoitov [mailto:alexei.starovoitov@gmail.com]
> Sent: Friday, July 22, 2022 7:55 PM
> On Fri, Jul 22, 2022 at 07:18:23PM +0200, Roberto Sassu wrote:
> > The bpf() system call validates the bpf_attr structure received as
> > argument, and considers data until the last field, defined for each
> > operation. The remaing space must be filled with zeros.
> >
> > Currently, for bpf_*_get_fd_by_id() functions except bpf_map_get_fd_by_id()
> > the last field is *_id. Setting open_flags to BPF_F_RDONLY from user space
> > will result in bpf() rejecting the argument.
> 
> The kernel is doing the right thing. It should not ignore fields.

Exactly. As Andrii requested to add opts to all bpf_*_get_fd_by_id()
functions, the last field in the kernel needs to be updated accordingly.

Roberto

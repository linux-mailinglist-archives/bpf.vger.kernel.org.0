Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA9595FD7E7
	for <lists+bpf@lfdr.de>; Thu, 13 Oct 2022 12:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbiJMKo4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 13 Oct 2022 06:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbiJMKoz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 13 Oct 2022 06:44:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681D715A2C;
        Thu, 13 Oct 2022 03:44:52 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Mp5dB54WKzmVC2;
        Thu, 13 Oct 2022 18:40:14 +0800 (CST)
Received: from [10.174.178.66] (10.174.178.66) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 13 Oct 2022 18:44:50 +0800
Message-ID: <cf6a99a1-e77f-113d-101a-5b5a52111df5@huawei.com>
Date:   Thu, 13 Oct 2022 18:44:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v4,bpf-next] bpf: Don't redirect packets with invalid
 pkt_len
To:     Lorenz Bauer <oss@lmb.io>, Stanislav Fomichev <sdf@google.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <bpf@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <yuehaibing@huawei.com>
References: <20220715115559.139691-1-shaozhengchao@huawei.com>
 <20220914111936.19881-1-oss@lmb.io>
 <CAKH8qBujKnFh8_g+npxHpo7RGFshus3N0iysmVBohTtG1X2yow@mail.gmail.com>
 <5a3c5ea9-d557-6070-d778-1092f3c51257@huawei.com>
 <aec8ef40-260c-4ded-b806-d381a3075ff0@www.fastmail.com>
 <c416473b-af8b-3bf6-7ede-e1198b3496f5@huawei.com>
 <bc69e8a3-d474-451f-853e-1c936f776ef9@app.fastmail.com>
From:   shaozhengchao <shaozhengchao@huawei.com>
In-Reply-To: <bc69e8a3-d474-451f-853e-1c936f776ef9@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.66]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2022/10/13 17:36, Lorenz Bauer wrote:
> Did you get around to submitting another fix for this?

Hi Bauer:
	Sorry, I haven't fully understood your intentions yet.
Can you explain it more detail?

Zhengchao Shao

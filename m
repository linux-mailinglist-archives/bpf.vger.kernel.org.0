Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B3A6EF82C
	for <lists+bpf@lfdr.de>; Wed, 26 Apr 2023 18:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239381AbjDZQLH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Apr 2023 12:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjDZQLG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 26 Apr 2023 12:11:06 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30A349E0
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 09:11:03 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33Q9VX1b024229
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 09:11:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=s2048-2021-q4;
 bh=hO6LH/hYAg7sCkMg37ZjZBXr2vrBUdyOdne7XRGUWWk=;
 b=Bcazb2PkM/Dxzc1GkgpguJz/rqCkfPGAUIZ12hoB21UBjHXQ7lh7nFxFg/B8Ytjdwkyu
 bfD0uJudZhY39UeebMvkT6qkvz5A55K2NyVnymqhIV2RMNTZtGlxXi6Z+LsBZeWOJXT/
 GcNsV0jP88uHSP2jUTXqkGy6pYNj9cZjWlxp/KRmakoV8n/iK2mkyYW3ehiaqSR+YC7v
 EBsCxyNqTMfpu+kmFylQSGFfYn3pktIllGE/d5alr7Uo33DafUiz2xxaUKT4lKIQOO8t
 Ftaw1xtdYAfr7uLdoJg9WuF3kCoo0awBQr3GPMV9cpzlsk9hYUT/OQklsgHWh5qijqSa Og== 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6mruers8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <bpf@vger.kernel.org>; Wed, 26 Apr 2023 09:11:02 -0700
Received: from twshared24695.38.frc1.facebook.com (2620:10d:c085:108::8) by
 mail.thefacebook.com (2620:10d:c085:21d::7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Wed, 26 Apr 2023 09:11:02 -0700
Received: by devvm5710.vll0.facebook.com (Postfix, from userid 624576)
        id 253B32B41702; Wed, 26 Apr 2023 09:10:53 -0700 (PDT)
Date:   Wed, 26 Apr 2023 09:10:53 -0700
From:   Stephen Veiss <sveiss@meta.com>
To:     Yonghong Song <yhs@meta.com>
CC:     <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: test_progs can read test
 lists from file
Message-ID: <ZElNDYRVTGCzxBOd@meta.com>
References: <20230425225401.1075796-1-sveiss@meta.com>
 <20230425225401.1075796-3-sveiss@meta.com>
 <3c83f3ae-c707-1852-57a6-18ac295a9f79@meta.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <3c83f3ae-c707-1852-57a6-18ac295a9f79@meta.com>
X-FB-Internal: Safe
X-Proofpoint-GUID: GlNLYpTVNt6ziiteHowoo6mBGKH9Y1FQ
X-Proofpoint-ORIG-GUID: GlNLYpTVNt6ziiteHowoo6mBGKH9Y1FQ
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-26_08,2023-04-26_03,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 25, 2023 at 09:25:40PM -0700, Yonghong Song wrote:
> On 4/25/23 3:54 PM, Stephen Veiss wrote:
> > +static const char argp_program_doc[] =
> > +"BPF selftests test runner\v"
> 
> What does it mean to use "\v" here?

argp splits the documentation string on \v. The part before \v shows
up at the start of the --help output, while the part after appears
after the detailed help text for the arguments. [1]

Happy to take all your other suggestions; I'll revise and resend the
patch series later in the week.

Thanks,

Stephen

[1] https://www.gnu.org/software/libc/manual/html_node/Argp-Parsers.html

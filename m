Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E64DF25B751
	for <lists+bpf@lfdr.de>; Thu,  3 Sep 2020 01:29:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBX3s (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Sep 2020 19:29:48 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:48072 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBX3r (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Sep 2020 19:29:47 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082NPeM4187510;
        Wed, 2 Sep 2020 23:29:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=vraYw2vF+OcptVUHzlg69BQM17t/OPbKKpZ8QBAx5C0=;
 b=cXdPz32+8PZZNDELXdUkQO8vNVwn1QjySK2mE4M43HskeJHwsSblebDEpoq2YuWUTN9L
 6LbgFI9sPFgBbCqATwYtwAZgDBfS1hc4lx90PFE96dbxchzEzZN858sdXpIzL4eMSEx+
 QIqt5nlV22xikC8ZyHtkCWLu2MaJusNutOQ4JXUZnJLAmO2kcLVE4G3woIPleefT4aqn
 jQyTfqKjxX0gIFEFRw2+gknok610Pp3RtdRWzVoev5LiqZVY3hd8svyLrmvyugHlnUkr
 cITkh1Y6un1juJvNjHV+lDE9Sk5TzDrRmAeWoSxqxpKN/5xHw2cqwd18oVFDOMKvitAp sg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 337eymdn3u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 02 Sep 2020 23:29:42 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 082NP61d155502;
        Wed, 2 Sep 2020 23:27:41 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 3380suwm2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Sep 2020 23:27:41 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 082NReIx013201;
        Wed, 2 Sep 2020 23:27:41 GMT
Received: from termi.oracle.com (/10.175.48.72)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 16:27:40 -0700
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     David Miller <davem@davemloft.net>
Cc:     alexei.starovoitov@gmail.com, bpf@vger.kernel.org
Subject: Re: EF_BPF_GNU_XBPF
References: <CAADnVQ+AZvXTSitF+Fj5ohYiKWERN2yrPtOLR9udKcBTHSZzxA@mail.gmail.com>
        <87y2ls0w41.fsf@oracle.com>
        <20200902203206.nx6ws4ixuo2bcic6@ast-mbp.dhcp.thefacebook.com>
        <20200902.161849.1363975274756227714.davem@davemloft.net>
Date:   Thu, 03 Sep 2020 01:27:36 +0200
In-Reply-To: <20200902.161849.1363975274756227714.davem@davemloft.net> (David
        Miller's message of "Wed, 02 Sep 2020 16:18:49 -0700 (PDT)")
Message-ID: <87ft7z21zr.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=813 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020219
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=808 mlxscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009020219
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi David.

>> On Wed, Sep 02, 2020 at 10:19:58PM +0200, Jose E. Marchesi wrote:
>>> 
>>> As such, the property of being verifiable is irrelevant.
>> 
>> No. It's a fundamental property of BPF.
>> If it's not verifiable it's not BPF. It's not xBPF either.
>> Please call it something else and don't confuse people that your ISA
>> has any overlap with BPF. It doesn't. It's not verifiable.
>
> I have to agree with Alexei here.  You are trying to create something
> which is not fundamentally BPF and it will create a lot of confusion
> and hardship on people who are working on BPF when you publish
> binaries with this machine type.

How would that create confusion and harship if the binaries are clearly
marked as containing extensions?

It is the lack of flagging that would create such confusion, and that
situation is precisely what I'm trying to avoid with this proposal of
using a bit in e_flags.

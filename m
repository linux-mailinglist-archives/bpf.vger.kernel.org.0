Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6FE2A3B46
	for <lists+bpf@lfdr.de>; Tue,  3 Nov 2020 05:01:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725952AbgKCEBC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 2 Nov 2020 23:01:02 -0500
Received: from de-smtp-delivery-102.mimecast.com ([62.140.7.102]:57890 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgKCEBC (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 2 Nov 2020 23:01:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1604376060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=zWSZUslS9wjYmSXqMY1j2f1IFb6ssBRY1CiBCtx1cjQ=;
        b=kt/g8qwsFD3NpAkSGHUWrSPq2xdNrSAPtPXiesHJ6491LRswhtCf6tvEV97F1M8UXQBhit
        Cnay7QDU/sKpsHFiB+mlc49CAbHQl+T4A+9OXH0bzd4fDZDw/aAZL7WhvneD+Q0VcQFCmU
        Yq1ca3n/oLpfOJKDRqCsepxytL+ThI4=
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
 (mail-db3eur04lp2050.outbound.protection.outlook.com [104.47.12.50]) (Using
 TLS) by relay.mimecast.com with ESMTP id de-mta-4-S1-ahqdbOACObIF0-1-VWQ-1;
 Tue, 03 Nov 2020 05:00:58 +0100
X-MC-Unique: S1-ahqdbOACObIF0-1-VWQ-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I6afn+k8oE7aBwSPrCAaNEdISU9SoDOMBpB8tlPoWotJBnHG1BOeADxPQ+7gJSzbCOC3VagH7rTyk3cY8GPPVLuEGihqfNZpHdO3YZmSZtmeKzzaCw+Wr1z2JF/u35qIk+ArqxxiOU4jcmhpd2eQZ7zw6aMa1HLqVFIwJzhDxqz4kZq1ErmUw3L87Vary5eyCz9VQhk8Cqtzx+ecmEWWQGSQNOaLKVYk/Ud+oN4EcGZ7JRqQpONyd7Tf0HVibHIuC194iUCFpAQ15JQBp0GOFEwh37QFMbedUwSm5QyWL2XEABNIimbtG79IdItxbgIUWulnJtrKurzzqp7o3UVTNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zWSZUslS9wjYmSXqMY1j2f1IFb6ssBRY1CiBCtx1cjQ=;
 b=ikratSr0t+mF+TMRvcyFCuQFYi8M6aAW+duZFrwNOZ7t93MOOk5AEdgsNjXzUWWidVC7EVOwIoRled04WBxu73iQQ9/H0lrgMgBzn7trvzqdyv/+yQQgJsE5PcXUtULvAZpZPNK3PuD8djcvCmLfsTZ4Wjr1XixJPJrZs9vnY2x7T/gXQ5qfebxsAaNXaBkBMuKkhdNsweFHfVlrYJCRxRO4XoDzjmlYRzDmJeM3IeBOhK8+YHhW1cmJQVDKswWi1ueY4pyAElnpB4QwNADG6EAHk3vij2pBHEri80Dw+SOA2OVPgLeyjh/VXHGct2sRGh8fBEVEfQPehHcJ65CT/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=suse.com;
Received: from DB3PR0402MB3641.eurprd04.prod.outlook.com (2603:10a6:8:b::12)
 by DB6PR0402MB2918.eurprd04.prod.outlook.com (2603:10a6:4:9a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.27; Tue, 3 Nov
 2020 04:00:56 +0000
Received: from DB3PR0402MB3641.eurprd04.prod.outlook.com
 ([fe80::c84:f086:9b2e:2bf1]) by DB3PR0402MB3641.eurprd04.prod.outlook.com
 ([fe80::c84:f086:9b2e:2bf1%7]) with mapi id 15.20.3455.040; Tue, 3 Nov 2020
 04:00:56 +0000
Date:   Tue, 3 Nov 2020 12:00:48 +0800
From:   Gary Lin <glin@suse.com>
To:     bpf <bpf@vger.kernel.org>
Cc:     andreas.taschner@suse.com
Subject: x86 BPF JIT failed to load a program with continuous JMPs
Message-ID: <20201103040048.GN19552@GaryWorkstation>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Originating-IP: [60.251.47.115]
X-ClientProxiedBy: FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::28) To DB3PR0402MB3641.eurprd04.prod.outlook.com
 (2603:10a6:8:b::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from GaryWorkstation (60.251.47.115) by FR2P281CA0018.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.10 via Frontend Transport; Tue, 3 Nov 2020 04:00:55 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea6bd661-daf3-466f-624d-08d87fad10e6
X-MS-TrafficTypeDiagnostic: DB6PR0402MB2918:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB6PR0402MB29181EC10FDB1A76A7C174BAA9110@DB6PR0402MB2918.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PAz/qSvAsFGiZaIe74+zzjN1LmiXIKrO7dmsstZN9FbZy7ZB7eEbHseKrgdM/5crL1xQLjn0eyMuZNQStwsU4iOePI5UdamO3pSZPdFBEHenBLsgbSTJNfvFGIPK4EPy6TZ2OrwEJ5L4vrAR7HM4jq7naN39Rtto+815SFH65hAX/M1NKeTXRM/ATmrP7b/3oixlwzUYO9G5Li1gQ9KA5zUWLjxiZYQFYDjE7HniR58fcZ6/VowvmgX3K6Q8jKwnm/t7VkHZSm3ABmnMdKoVrLfjVX2jjgJHnmOS+j3Bdszz2kwUp+ntHxb1PDBN82UG8qjVQbUGYTkEDB+q+SQC2FcjcUR/zEE8UTzjH//3WkruS61TeJ8Hpodh7k/wuibi1Xj61p42p6sBg+3ELBO16Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3641.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(366004)(396003)(136003)(346002)(376002)(186003)(66476007)(8676002)(4326008)(956004)(66946007)(66556008)(8936002)(26005)(83380400001)(16526019)(478600001)(107886003)(86362001)(316002)(52116002)(9686003)(33656002)(55016002)(6666004)(33716001)(55236004)(5660300002)(966005)(2906002)(1076003)(6916009)(6496006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: FTebK1MxJK+tDCoDaD7Hqb9G8nwr5Agx5dj97LEQYmKMs4EbNTacsvDi8CG6Kag0faUXlQ5MxKZk3+IHJSohGAmES1e3Maj0C98jIzT4TwOREXgJcFJf/6iFRwrkFIPva3MF29ZH3udHL3TAPFXNUAkPXl45FbdvIA+qRjFSy+NKkBRZPoCZRHP30mUbyr9H7NNrGOlC5diojpf7WFfu342k3u7g5+xNwNKdcACekFd0uk/xgXHYC1G6gExVvM5sGG0LrwrM+sqxHtwnH6daNGTUlmnN8F8Zdtfikov1fPLd1PhZrIXiLaqPg/q7uI0wz/nav1OLUqe2vBXhyTKdudFYG7vfpSJxz3MtXNSSjwvK+5pbS6oQ7PZIfIEBs02m6YFCTqbuC/uX7KBM50TZD1o3iY//et4bzdecuI1M72OIehGfbRqQgVwvYfbumtyDONZnxyHduhhSOWdZ65MbmjCCf11WCHbInJclwY80qL9IHzJII4Tq5cYQk5kzaxsNI29jUmm9ug/bX59NGHk1sRVrHps/zzfc7Sclpca+srSxdvDA1nFbxB6pS5DZ2hoHxf+G9I4L4Bu06Jbpd4U4YXjd6BlvHeSIIBfOvi8StD41zjcMPj//Fvmpj143LoZ1XSJnCbzZaTknoeMsV15rwA==
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea6bd661-daf3-466f-624d-08d87fad10e6
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3641.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2020 04:00:56.4577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7bTnZ1PigRxsQ9+3Rm6jUeCoDxBIC++uVGX7c/yVol+5uCViQQktMR6S/Pc2poKI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2918
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

We recently got a bug report from a customer about the x86 BPF JIT, and
the bpf program is like this:

l0:     ldh [4]
l1:     jeq #0x537d, l2, l40
l2:     ld [0]
l3:     jeq #0xfa163e0d, l4, l40
l4:     ldh [12]
l5:     ldx #0xe
l6:     jeq #0x86dd, l41, l7
l7:     jeq #0x800, l8, l41
l8:     ld [x+16]
l9:     ja 41
  [... repeated ja 41 ]
l40:    ja 41
l41:    ret #0
l42:    ld #len
l43:    ret a

They declared a sock_filter array with a lot of "ja 41" in order to
replace them dynamically with other BPF instructions and attached the
program to a socket with setsockopt(SO_ATTACH_FILTER). It worked fine
with BPF interpreter until upgrading to the kernel with
BPF_JIT_ALWAYS_ON.

In the beginning, I thought it's rejected by the verifier due to
unreachable instructions. However, the verifier didn't involve since
it's attached through SO_ATTACH_FILTER. The program was sent to BPF
JIT directly and rejected with ENOTSUPP. In the end, I found that it
failed in bpf_int_jit_compile()(*). Every time do_jit() was invoked,
it removed one "ja 41" right before "ret #0", so bpf_int_jit_compile()
failed to remove all "ja 41" within 20 runs. If I reduced the number of
JMPs to 19, BPF JIT accepted the program. It seems a corner case that
BPF JIT could not handle.

A quick "fix" might be iterating do_jit() until the image converges,
but I guess the limited iteration is designed to bound the compilation
time of BPF JIT, so I'm not sure if this is a good option.

BTW, as a workaround, I suggested the customer to replace the JMPs with
0 offset JMPs so that do_jit() can optimize them out in 1 pass. But I
still would like to know how to handle this kind of programs properly.

Thanks

Gary Lin

(*) https://github.com/torvalds/linux/blob/v5.9/arch/x86/net/bpf_jit_comp.c#L1876-L1921


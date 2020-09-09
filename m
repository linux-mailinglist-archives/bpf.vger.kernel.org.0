Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD3D5262711
	for <lists+bpf@lfdr.de>; Wed,  9 Sep 2020 08:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725840AbgIIGRr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Sep 2020 02:17:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:14246 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725826AbgIIGRq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Sep 2020 02:17:46 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0896AMHx020615;
        Tue, 8 Sep 2020 23:17:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=date : from : to : cc :
 subject : message-id : references : content-type : in-reply-to :
 mime-version; s=facebook; bh=bAqtFt4HG8p6UA8OrrAmiZh/xOYgmPInzTufYtAsBfM=;
 b=HADDi6DmdSvAl2AT47lg+4SIfjr7SPpIin9U6rowyZ2NUEkhZBwXGXLNrmGoPefkr4RM
 FFFgntMRYSbo8z0Vwki2vr5TU+fP78K0d8e4qtUMnFYog+RGN8a/d7lCfy7AjIYO5YKq
 uQvE5KgJ34fO8PXoEAoCdfouYKvycjZhuyI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 33c86mgjfc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Sep 2020 23:17:31 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Sep 2020 23:17:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kiVLhLDyop2kNwEZgUfdBZ/ggJCaVFtUSSB8LDa4dJ4qyJhcPze3f3UmBqomJxAxZg0HC8/rviGg/leO2FasqEWsoBAOa2EB/dG834OwLnPreluTBHl1oZcYHZUkfN/yg5n/hPsL2cNFBhr0pnfjX1GeiDzzYNITmssMfPR4kc1CR2R1AQhi6MHy48aqB1hAuZZkEKjI5KIyRVpVIuMNEqLQKyA8kPFYDGf7xoKrOJuIh44oNzRfbyUST7sHgG/xN8AUWe0sjohR4gcQzNF4ns2tM3RM0l5dCmfZAUf0J7n/vScvcFFqVt6QDCtty7vhR/2ZKlcXqBJJsgdoX9uvYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAqtFt4HG8p6UA8OrrAmiZh/xOYgmPInzTufYtAsBfM=;
 b=gOOgpstJTL4mcB2KKkQ1RFJQXFE0/+VBf58vugn7uWcZn7LlLCyifVQ1cG0j4ynVCtHRzpS2sRcwy6/E+EiufJgTEP3X9XWjfVEMS9NXNxnMBvfdM/SulzIeZEq/93U6sSiRtLm8IptUEQMzQqANwSIuJtyBqZua8LRaIRuKiNBIylUyOlP+MuNE+CREV0IlWEU3F5/12LMucqiMstH7LyRRcxLJGCRcu685Ww3umg0yZMyBeR3i8XaqXXELd1iGHC/ZxiujHGxmn5cnVIsy8r9K7tfywtZRntHNZD15EifElo8y+D0Pg6Ggcs3dAMdHfjjdyfLSLVohjMHYLdLfTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bAqtFt4HG8p6UA8OrrAmiZh/xOYgmPInzTufYtAsBfM=;
 b=Qp8qEoOEdEUNZhe3qSinK6TJlb6EWk/TrW78h9pe8kpYisktQrRJL6UvPY+iiCUz0ulPFmfzV12DrkdFief9LQ6+XCRgil1Nqj+0sy5iclbMmd7ePMoZxKLY7b4ur3WsXGnJw1gGdiu31fuLJiM1mQvMKO0kb2QdHCfYl0SnCek=
Authentication-Results: cloudflare.com; dkim=none (message not signed)
 header.d=none;cloudflare.com; dmarc=none action=none header.from=fb.com;
Received: from BY5PR15MB3571.namprd15.prod.outlook.com (2603:10b6:a03:1f6::32)
 by BYAPR15MB3047.namprd15.prod.outlook.com (2603:10b6:a03:f8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 06:17:28 +0000
Received: from BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb]) by BY5PR15MB3571.namprd15.prod.outlook.com
 ([fe80::c13c:fca9:5e04:9bfb%3]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 06:17:27 +0000
Date:   Tue, 8 Sep 2020 23:17:22 -0700
From:   Martin KaFai Lau <kafai@fb.com>
To:     Lorenz Bauer <lmb@cloudflare.com>
CC:     <ast@kernel.org>, <yhs@fb.com>, <daniel@iogearbox.net>,
        <bpf@vger.kernel.org>, <kernel-team@cloudflare.com>
Subject: Re: [PATCH bpf-next 00/11] RFC: Make check_func_arg table driven
Message-ID: <20200909061722.pvjjhmzfh3xdrxcw@kafai-mbp>
References: <20200904112401.667645-1-lmb@cloudflare.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
X-ClientProxiedBy: BY5PR13CA0009.namprd13.prod.outlook.com
 (2603:10b6:a03:180::22) To BY5PR15MB3571.namprd15.prod.outlook.com
 (2603:10b6:a03:1f6::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kafai-mbp (2620:10d:c090:400::5:d222) by BY5PR13CA0009.namprd13.prod.outlook.com (2603:10b6:a03:180::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.8 via Frontend Transport; Wed, 9 Sep 2020 06:17:27 +0000
X-Originating-IP: [2620:10d:c090:400::5:d222]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e85117a5-c9b7-455e-740b-08d85488067a
X-MS-TrafficTypeDiagnostic: BYAPR15MB3047:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB3047FBF33BC33A1F322B109AD5260@BYAPR15MB3047.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b1zM7XV5NBbRmpxoHBG0LI0UWuMlMSnDdT4e7zY4v+/MANm2gA8coak2izJnxYPkcu0TdD2aloZIKWrKvNFiEnJTpzq/vTnxjYvaGRLx0Q6nQloEcQxsJs/7kHMh89jPT46nEfrIGh4d8OD+/hVnNeAMyPJVkoW2uP/gnPVdRdO6KxRgEK7nKYLRJgwYpotw1R2P8SS4tKshF0mNs4NfNeSxZmHHxJFNsWsPiX+PLcpa7lpd2HUCXcTr5+G2hQKTDO9GpvlwrM5IFXrqUhVKFcbZyBNqYFXKJIIhfuSzhsEa8rGJ2EvsmqiN5/cLs++M1FQLda6hnEHZQ5zfijkhHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3571.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(396003)(376002)(39860400002)(4326008)(1076003)(16526019)(8676002)(186003)(478600001)(55016002)(9686003)(86362001)(33716001)(52116002)(83380400001)(6496006)(66946007)(66556008)(66476007)(2906002)(6916009)(5660300002)(6666004)(8936002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: Q39JPMGWx0ZrNW5mBAQzmoskWWX0Z4JHp1OgtTBg66+VlyLUslYni/pJrCKNe44ysN8Ksf1fz2sWzKRDeBuygjj25jJpiNOQjoBxx1q1EeBGah6CJGk6MgoiP1yyYEJIC7XpGCP00BEA1J+Rzf59rmvhqBmJKSETAp8nLoyf+rJ9sp65Ehytp1Qz86pr95t5c0V24sD0bMfU8rDaapngS8gYffMuZhiO7KsFxkDYgf5j8ROx6kHUREdn47v76OIGusMQoZ7gXqA4advcwJEGECjXDhv+vxhmlNqAEbrVK75ImILQV9E0DudzQBNTe9W3JDkLTKP0YhfBVX9VIFjpmWn1gPYJjNszdbFRg0m9I1KcTpj7i8pHXe6707C/lX/UubN4BBp3DXwNmfFOa39Mr80u9tYkJUvYURvtuInAA8JoFw8aIpwnUBaSzKdlhotuX2W13IgXpqqOmy/P7c5BiCoAaAm/PB5tzG7NNB7pCALHsKbasR1Js+73KvBa4T4kLC9jKZoXTSuTMD5gLpZv2PCrLk8GchVrYjF5JUOWOeaCAISGtDOdg61zvwikYiFtPgyepMfUnZBtU0TttQVLHsA3RA+WKaldCeHxrc0hZiAMcuiJvrnLxS6KOdrkPRYsF9TvLmQ5KRBQgsRWnQFDfhb7iy6jLBPVVlrPBxJOdII=
X-MS-Exchange-CrossTenant-Network-Message-Id: e85117a5-c9b7-455e-740b-08d85488067a
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3571.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 06:17:27.6007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XDQdJIVIPBQW8O6wdeAOjmDF6lEI034flSJY/asT42A0bXUnR+gXAnPkfMWjJmwF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3047
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-09_03:2020-09-08,2020-09-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 suspectscore=1 lowpriorityscore=0 spamscore=0 mlxlogscore=944
 clxscore=1015 bulkscore=0 phishscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090057
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Sep 04, 2020 at 12:23:50PM +0100, Lorenz Bauer wrote:
> This is what happened when I got sidetracked from my work on sockmap
> bpf_iter support [1]. For that I wanted to allow passing a BTF pointer
> to functions expecting a PTR_TO_SOCKET. At first it wasn't at all
> obvious to me how to add this to check_func_arg, so I started refactoring
> the function bit by bit. This RFC series is the result of that.
> 
> Note: this series is based on top of sockmap iterator, hence the RFC status.
> 
> Currently, check_func_arg has this pretty gnarly if statement that
> compares the valid arg_type with the actualy reg_type. Sprinkled
> in-between are checks for register_is_null, to short circuit these
> tests if we're dealing with a nullable arg_type. There is also some
> code for later bounds / access checking hidden away in there.
> 
> This series of patches refactors the function into something like this:
> 
>    if (reg_is_null && arg_type_is_nullable)
>      skip type checking
> 
>    do type checking, including BTF validation
> 
>    do bounds / access checking
> 
> The type checking is now table driven, which makes it easy to extend
> the acceptable types. Maybe more importantly, using a table makes it
> easy to provide more helpful verifier output (see the last patch).
> 
> I realise there are quite a few patches here. The most interesting
> ones are #5 where I introduce a btf_id_set for each helper arg,
> #10 where I simplify the nullable type checking and finally #11
> where I add the table of compatible types.
> 
> There are some more simplifications that we could do that could get
> rid of resolve_map_arg_type, but the series is already too long.
> 
> Martin: you said that you're working on extending PTR_TO_SOCK_COMMON,
> would this series help you with that?
I skimmed through the set.  Patch 5 to 11 are useful.  It is a nice refactoring
and clean up.  Thanks for the work.  I like the idea of moving out the logic
after "if (!type_is_sk_pointer(type)) goto err_type;" and moving the null
register check to the beginning.

I don't think this set should depend on the sockmap iter set.
I think the sockmap iter patches should depend on this set instead.
For example, the changes in patch 1 of the sockmap iter patchset that
moves out the "btf_struct_ids_match()" logic after the
"if (!type_is_sk_pointer(type)) goto err_type;" should belong to this set.

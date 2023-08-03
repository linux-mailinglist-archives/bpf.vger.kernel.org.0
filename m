Return-Path: <bpf+bounces-6828-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C068776E2D8
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 10:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7660E281F46
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 08:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCF814A99;
	Thu,  3 Aug 2023 08:21:52 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9008D8836
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 08:21:52 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD53AB1
	for <bpf@vger.kernel.org>; Thu,  3 Aug 2023 01:21:49 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 372MiA0M024932;
	Thu, 3 Aug 2023 08:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=lDiWFi9aQncTclR5xkaJgDrJ0uhGGpo+3sKn0iQ1j7Q=;
 b=ahZd6n55a01kl6jleQTTJBjGWsSJoI42GLtPAyDD6zqbCIjwYxUktEtFPW8ji240FRdO
 uyqUSS71jU4VYvWh7PhnBd2u8NbpYkFKEQn5VDK6qeQKb8p1JEDm7+Qa752gIN0Auykv
 /yJ8Z/ICnDbK5+G9Qy1m2ir+eImheJhMOCQGDwMnhiFyUKcIRTAKL+uZWCJVSMVsuTXv
 MYLj4ucLjW9c28I0tgYjBx6MlwLs0Fc5tuIfjERehF/aARak70lVjAtGXnZ0Rabjhr4P
 LfLz3DGDsIcktFyOXOtBehlLtGWp30/YzqP//nauFJPep/VbRQ0Eq/haGOd2/TbNJu3s zA== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s4s6e91cm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Aug 2023 08:21:28 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37373d0U006711;
	Thu, 3 Aug 2023 08:21:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s4s7fh97d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Aug 2023 08:21:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtCcTp1BfUnEdiVrejHmdftT7UxHs1k4rh9/aDiL/IjOvg/TReH/VnPNl3yk/7SckqfRD1w2eUt76aGBcPxBLJQtUqUvn0OfloR1I/crn0wGWSCsz5k0wrh6ZCRG69zAWxlDcU2RJzqMff5vo5QdYzuLSTMqaDrvYhC+KfI937JCwDZ1nWusYMwEd3CRC6+63Q4vAAVFJxzyMDa6bngV59xEmXfaXynmlvXJSZhMo/Qci/j+3Qz4ELslQeTGqXdw5gWP20CcW5aN+vUn212zda8kGN0j8IKwBC7vPiQGXvG6Oqk8V16xw6dqxC5/wHNWPoDmMn8IN3sTGIwGimSkVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDiWFi9aQncTclR5xkaJgDrJ0uhGGpo+3sKn0iQ1j7Q=;
 b=DBzRNAN3QL32qO9I/EwJJb26n610CsEwJP/iBv4YgQB8SkzkXmOtp65bQbiQI3MJEwWKl7BJuhNdprOsAbJlKSC3gxQruJboZMyYUjAfZ41s0qgAv4PmFa/7OiqlhevMh79kJSlx63/rL0nXvWSeRRZLGC+ya731mxF8oUh35Io0El1zhjqgoFKG5725dBYB3Nud8PpNZHy48YG/fwu+Y90nFzV1tJUrbsX04OmT0pDz8JV2ZWH3kLZadjcboNzR6waKKu9EyVTabHbe8ltVWhG5akXUUJL/cJCnXNJcuuRYta4XzoIYMlexT64pkwEW/6BDk253ajoUsLIhy+AJ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDiWFi9aQncTclR5xkaJgDrJ0uhGGpo+3sKn0iQ1j7Q=;
 b=lSxFLC0Ce1qmdtOFlZInY+P92+g/aySjrSU3S0zQtCMpToUyqH6BdkesvGMUclF2Gs1i3yq1W1fMlgPoQJRmCaZgkNmPLgT2PlM39Q7GHAqJklIs5cK3qbRP2usNyTYriltu/K7zC6KslD0WodJTIy+TZKj+szqlONVVcoJxYaY=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Thu, 3 Aug
 2023 08:21:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6652.020; Thu, 3 Aug 2023
 08:21:25 +0000
Message-ID: <998f8e89-fb00-820f-15d9-1d227cc09e54@oracle.com>
Date: Thu, 3 Aug 2023 09:21:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH bpf-next 0/3] bpf: Add new bpf helper bpf_for_each_cpu
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Vernet <void@manifault.com>
Cc: Yafang Shao <laoar.shao@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov
 <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
        Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
        Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>,
        Stephen Brennan <stephen.s.brennan@oracle.com>
References: <20230801142912.55078-1-laoar.shao@gmail.com>
 <3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev>
 <CALOAHbAnyorNdYAp1FretQcqEp_j6mQ93ATwx02auLTYnL_0KQ@mail.gmail.com>
 <CAADnVQKwY+j6JrxJ4dc1M7yhkSf958ubSH=WB7dKmHt9Ac9gQQ@mail.gmail.com>
 <20230802032958.GB472124@maniforge>
 <CAADnVQJnv5mC2=s1sQ8YKNj6gZXyXHeuNyaBJjk3D90VrM0iBw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQJnv5mC2=s1sQ8YKNj6gZXyXHeuNyaBJjk3D90VrM0iBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0155.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::7) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b94ba0a-b72f-4f9e-0c41-08db93faa098
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	IYX5JTaBw2Na87Zf0Ksmkw3wPtWgTMHstJm+53NMUgQwHWPH6pr4lqf4tgpW9un1qWgveC0uXGckpvEwcuMzZJJKjf9Xeo+uHrEVf1e6a9fGHgRnZQnbZ8hG+KR6ySLnQsVkC0Zz3Kgz+aOuySFknqGOLg37OgKFQuF3hpOFM2uA72Y9+dg7qa90dwyFXbLx2d8UDfozH/3jxNRclFz31hlxn+V0wlkmxy+pQ+UCMAy6gka6Qk2i4k+EJ/12Ha02F6P+bvnErLZ1E4ccd1TuRQZxoxmXFooUJs5unRRsGS2onw01fOo4uuM+4pzPVr5TXa+Tc/q6DHQu3PnhgwHofO54wwseRQcgMtsRURobDIGv0ITTAT9Uvwc4fz+kqw3W/EnH03aJec3nkuVMuO5ZCkuRo3vhKEtYFyY9l+c9DYa0QkYjRBFCJ0pWvoS/10S8ePsuuFTLmMrm5ZLN/8ss6SlG+d5/nP3J16tMu+FnvRCMEED1pESHxjpSJBiYHeEHdc5JW58smzoVmpQHSqf8zAqOHl1L8faLinBUnP2biOyF7TVhGlWOdixOEN2/mF2RG59YDXdk+wBAN8UfVB7XSuiZarQvdfZvuHh4yBSBfQSiCB27/oiA/3L456jQGME9Wu3wc9EQ/clWSdMkMOdd+vLmU2XdmV1TplxC0gO9GSQS+90dTT8kVqeY+ZhpXom0
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(346002)(39860400002)(136003)(366004)(451199021)(107886003)(478600001)(86362001)(31696002)(966005)(36756003)(6486002)(6512007)(6666004)(316002)(8936002)(8676002)(41300700001)(5660300002)(31686004)(4326008)(66556008)(44832011)(66476007)(7416002)(110136005)(54906003)(2906002)(38100700002)(66946007)(2616005)(6506007)(186003)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b0xIVGJwRUsxN25GMUFXblhGZTZQZnpDTEw1c1h4SlM4a1lmRDkxNDNseGZ1?=
 =?utf-8?B?YnhnenAyd1dmSHNYNXRGVHFLZHJqREtRc0dzdlVUOGNOamhjOHRNcENycmha?=
 =?utf-8?B?NE5UeGJ5eUUvVythWDZyV2NieExXNlEwT3pCdW1OeHVSV0ZwUzdZd1NpM292?=
 =?utf-8?B?aDdBdk41UnhjTEhJdFBlMkJ6bXRyc09WdWFHNWZlOE9UV0NZeTVPMzE2eEVy?=
 =?utf-8?B?aVJoL3BzaC83cnJLQ0cybGdxSlIyRVY0SVVKSEhPU0lDZUh3SFVRZzNURXNN?=
 =?utf-8?B?RjMzczU1bFdSelFUMUkzNkVuNG05SkIvc21Uc0JnYzE0bytsWi9MRHY4K0Js?=
 =?utf-8?B?Z0p5NlNtY0dDZkJrV21QVldMZ3pWb2FRT2JyRTJZMzhmdG0rR3I3WkxnbUNK?=
 =?utf-8?B?dWxjZzdGZ3JkaXp3TzlyWnVkZWJLbnVJeUNDUlcydTd6eXU5V1RUYVZvOHVQ?=
 =?utf-8?B?Vk45WERjdGQwM3U1T1NMSFVnb0szejk0RlAvcTZDYmxrd2E4S0ZiVVR3TC94?=
 =?utf-8?B?OEc5TUhBQW5GeTVONXFka2VrZ2VYa2hIVDJER0xGOGhJNTdFc0hZbjQxcWpO?=
 =?utf-8?B?ejlwZjFxY214QmJOUkpEajNtYjBKWlhyQlZGb2k1dk51YmI4VzVZUEJKUjZX?=
 =?utf-8?B?MTNZZTI5Y2dObXRtbngwUkUrM3V2S3Z5KzNZVGFacFFweDAxZml3T2NuR0pk?=
 =?utf-8?B?V1l5eFFzb0lWclZPTDdHblpHSDVFeUp4d040YjFxWllNaVdoMmhzaGVUZ3Vh?=
 =?utf-8?B?Y2xVWUo5RGdHaDlvbnR6K1ZvcnpzWEV1NlJUcE9NQW9YVU5vLzFXakpMNDVB?=
 =?utf-8?B?TjFhaXpqTUo1QXFXNndxd0dYMG9adVVvUXVPbk1SM3F5NkNTWlk3cS9aNHlv?=
 =?utf-8?B?OG5GT2hIVkRLbFhGKzJvK2djWGVzWEFtY09seks3Q1NLY1IySGhpTXJtQVg2?=
 =?utf-8?B?c2RNbnJVMHYrWExTMWw2L28zQk8rR2xPZ21Ba2FVbExhdnA0TXFZenFyZm53?=
 =?utf-8?B?ZEl0S0J5eUQvcmNJY2pwZEF2VWNiV2hDZ1FDUlgrOVZ5b3FuUmJJaUxqcXlp?=
 =?utf-8?B?SEZuZGZQQWQ5QkovdGhKYkw4enNGU0tHeGUwcCtoUXN3MEdOc1BuKzB0TVV2?=
 =?utf-8?B?aiszdmpieUhQR0dtYlJNTytCVHBSTnE4SE93dldlWXNvOUkwbDZSQnUyVm5a?=
 =?utf-8?B?NzdXRGg4bE9WRXVUYVRydDg4Y1p5UGRuY1BydElEdzA3QXZ4dWZLR0Q4NmJh?=
 =?utf-8?B?a3NQVmtiaG9RemZsc2FYTTlURDhOdUtBUFVveGd6d1ZtdzNVb0k4b2M1c2w0?=
 =?utf-8?B?cHF5ek1pcGg0OGtqWTVOZElzNVp0WkpaUXpYdWdabXlGOEpVdDExQnZrYmda?=
 =?utf-8?B?TzJxVnlVS2dtUWFIbE9UT2pjNjg0ZUhJbmViWnBVSjIzN1pkQSs4YmZtYU1C?=
 =?utf-8?B?c3g0UytkVHVrVVcrQ25mODdCaG9nS2M4S1Q5SjZTVzdnamhKbXhKRUZoN1J5?=
 =?utf-8?B?RnhYOGlNalRTbFh5TkxmeHJ6VzNjdzVpa212bVVwejkrN1ZJTEFmZDcwNTVv?=
 =?utf-8?B?T1ZhbTdici96bkhscW15dkNCUHFqSlRRbG1jQWpWbkg3WkV3MjFlWWhrVG1U?=
 =?utf-8?B?eXJmSzVKbWF2dllKcmlWQTh6cTg3cjdUWVpTU2dKQkVjaFg0UlhCQUJmQWhI?=
 =?utf-8?B?UFVaTzZ2bU0zN3c0S0hmZkJWaEpQVnNlcmxSRThjcWwydDJrNDhOTU80bGps?=
 =?utf-8?B?MWhHZVhZaERQVW4rZVViRTdhSDlLY2ZxaWJGSVBYak5tSytKSEFpdzhzZXBJ?=
 =?utf-8?B?U2JBeEt4VUFhUUdMNlBtNFplSUkxRk1wUVlTR3k1OGdDeHFaUnl1ZG5vbVp4?=
 =?utf-8?B?YUoyNjBJTGlZSjJ5RzdRRUplYUNvTzdaK0RFZWRKd041cmpIRzk5eU1Uckpt?=
 =?utf-8?B?ZHRSTC9BdEwrZmNLWXY2N0NueFlLSVdLKzRYQkQyZHBxMFRacno5dEg3ZVBz?=
 =?utf-8?B?VTRHWDVNNXR3dFQ3S3RiZ0h3YjlBTzBZL0txY0VLUnZzTkNWZFFBYkwrckhP?=
 =?utf-8?B?cHl0WDJOZlFtcloyUDY5VDExSjZJWTdtczd6dExjVEhwTkc5TG1ENVltc2Zs?=
 =?utf-8?B?Rk90TlIxV2R1QU96d3YxVzh4T0YvYkw3ZzlidDduV2pkY0xoVUk5WmZjaGV3?=
 =?utf-8?Q?Q62HfOHLX7Z8PK1n0Dp16GE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?utf-8?B?UmN3M3RUbzVDU20xekVHYVgrZmd3a0dreVc0UVNidklhMGRySGx5eTFtWDI0?=
 =?utf-8?B?ck52WmlyUlFtMVRMUW5DdXhiTlhqSFJRUjU0dEd0V08ycTJaWmk4c05HSC9j?=
 =?utf-8?B?akwzSHZXWHNOS2Q0ZGVlNzk3d2ZjRmRVek1xd044MG5IdHI5UklSMW5iWExx?=
 =?utf-8?B?cktQV2dZbVJoT3dCc1ZHU0haVGNpZDBKaUZncEwrUWpBVnh2dHl6NWlQUUVQ?=
 =?utf-8?B?cGF2T0JFRVVNWEpNYzVReEQySFNTZmhQc0lHY3d6TWQyb3YxUGU2ZGtvZ2tl?=
 =?utf-8?B?L0sxUWNKRXE3RnJWZWdReDlLVytka1JtK3ovbVkyZ01sbWdCMG4rd0NsQ1dw?=
 =?utf-8?B?OFREN2FzWmtGeC9UaVZDNEZCekJzSk9vUlNBc1pjc3VQQldwaFdDWmtlUmhV?=
 =?utf-8?B?ZlZLSmYrV2FuZG0xRnhBM2czYXpzdjNMY1pwWjdRNDlXaXlvZFNNc1BQb2tp?=
 =?utf-8?B?VjJhdmVzb0pRUlhJVFdTZFBndzBKSnVremhYY3MzeXNQZkN0VTRKNldFdzR5?=
 =?utf-8?B?MjBaY2wwdFl6Vys3QUJmVmF5WkR4MzdjL3RXallsOXU1WUZsSm5SR3Z2KzRh?=
 =?utf-8?B?eG5zZnRkMG5DVWUyZ2E3K2c0MW41cE1CaGVSUzczRHpvTVM4bTNSSW5hY1Fn?=
 =?utf-8?B?TXBFSys1cEhBcEtYWE45ekt1d0Y2aE5wMG40S1VOWUtGK1M0QklTSEo0WWli?=
 =?utf-8?B?dEFIRFBINzVYTTNPVGcxQXJKQjJlOGRDaUZtOUFOdXZ3TmdxOTB3SWxvRVh0?=
 =?utf-8?B?TUdyMUFEeEZ2YXJtUTlkd0xUbksxVzRlNUl1WWJ2c1VST3BDa3NxZzZLSUIv?=
 =?utf-8?B?VFpxNFZncTBucUlUOThnK1V5STVLSG92c1RMcDc3TXFoMnNCcWFpdUk1SzBE?=
 =?utf-8?B?YzlsTUE5dGV4MCtDZTB3YUdIQks2K2FURC80RGZxRmFlRzBkV3JOWGYvQlJv?=
 =?utf-8?B?alh4VXIwSDVEOGNkZThnQi95VEVWLzUvNmQ5SDc2RzZ3SGJXOTJoem9tM05U?=
 =?utf-8?B?RkIycVdJeUVEd3VvY0VzQ0xqQTUwcERvZ1BkcHNSSmYrdkQxWHVDT0ZuWFVM?=
 =?utf-8?B?S0NSdU1OODFnMTcwZVAzUmhEQ3hUVUlrdm1JRGFaVFJRc2s0dFlvajZiTkIv?=
 =?utf-8?B?aDZmdDVGTERUZGpwQ01ib0dzcG5mMnVSWFBFcHBVNEdPRjNKRHJWOG0zZWVy?=
 =?utf-8?B?RXNOaHhQZzZIQXlKN1NGMnVVWFZBaXJQd2FiWUZzbHo0ajVZZVN1cklIbjdu?=
 =?utf-8?B?c1BkeDdrMHVWSUxuT2prS3ZKNzd5NXJwTFEwRzA0cUhvaHNEdz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b94ba0a-b72f-4f9e-0c41-08db93faa098
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 08:21:25.0546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kyjVd2KTH9WOgNUamCb1+zctrRzjQB68YJHkG2hgUmG2VjC+T2O1vUUnVQkPWji4VGt8jwmffiYr3xMTIu46OA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-03_06,2023-08-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308030073
X-Proofpoint-GUID: jd1PRdvbmxNfwcAlUYJu4FYdyUQ6bOw0
X-Proofpoint-ORIG-GUID: jd1PRdvbmxNfwcAlUYJu4FYdyUQ6bOw0
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02/08/2023 17:33, Alexei Starovoitov wrote:
> On Tue, Aug 1, 2023 at 8:30 PM David Vernet <void@manifault.com> wrote:
>> I agree that this is the correct way to generalize this. The only thing
>> that we'll have to figure out is how to generalize treating const struct
>> cpumask * objects as kptrs. In sched_ext [0] we export
>> scx_bpf_get_idle_cpumask() and scx_bpf_get_idle_smtmask() kfuncs to
>> return trusted global cpumask kptrs that can then be "released" in
>> scx_bpf_put_idle_cpumask(). scx_bpf_put_idle_cpumask() is empty and
>> exists only to appease the verifier that the trusted cpumask kptrs
>> aren't being leaked and are having their references "dropped".
> 
> why is it KF_ACQUIRE ?
> I think it can just return a trusted pointer without acquire.
> 
>> [0]: https://lore.kernel.org/all/20230711011412.100319-13-tj@kernel.org/
>>
>> I'd imagine that we have 2 ways forward if we want to enable progs to
>> fetch other global cpumasks with static lifetimes (e.g.
>> __cpu_possible_mask or nohz.idle_cpus_mask):
>>
>> 1. The most straightforward thing to do would be to add a new kfunc in
>>    kernel/bpf/cpumask.c that's a drop-in replacment for
>>    scx_bpf_put_idle_cpumask():
>>
>> void bpf_global_cpumask_drop(const struct cpumask *cpumask)
>> {}
>>
>> 2. Another would be to implement something resembling what Yonghong
>>    suggested in [1], where progs can link against global allocated kptrs
>>    like:
>>
>> const struct cpumask *__cpu_possible_mask __ksym;
>>
>> [1]: https://lore.kernel.org/all/3f56b3b3-9b71-f0d3-ace1-406a8eeb64c0@linux.dev/#t
>>
>> In my opinion (1) is more straightforward, (2) is a better UX.
> 
> 1 = adding few kfuncs.
> 2 = teaching pahole to emit certain global vars.
> 
> nm vmlinux|g -w D|g -v __SCK_|g -v __tracepoint_|wc -l
> 1998
> 
> imo BTF increase trade off is acceptable.

Agreed, Stephen's numbers on BTF size increase were pretty modest [1].

What was gating that work in my mind was previous discussion around
splitting aspects of BTF into a "vmlinux-extra". Experiments with this
seemed to show it's hard to support, and worse, tooling would have to
learn about its existence. We have to come up with a CONFIG convention
about specifying what ends up in -extra versus core vmlinux BTF, what do
we do about modules, etc. All feels like over-complication.

I think a better path would be to support BTF in a vmlinux BTF module
(controlled by making CONFIG_DEBUG_INFO_BTF tristate). The module is
separately loadable, but puts vmlinux in the same place for tools -
/sys/kernel/btf/vmlinux. That solves already-existing issues of BTF size
for embedded use cases that have come up a few times, and lessens
concerns about BTF size for other users, while it all works with
existing tooling. I have a basic proof-of-concept but it will take time
to hammer into shape.

Because variable-related size increases are pretty modest, so should we
proceed with the BTF variable support anyway? We can modularize BTF
separately later on for those concerned about BTF size.

[1]
https://lore.kernel.org/bpf/20221104231103.752040-1-stephen.s.brennan@oracle.com/


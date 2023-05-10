Return-Path: <bpf+bounces-287-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4FD6FDE3C
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 15:10:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 845E42814A7
	for <lists+bpf@lfdr.de>; Wed, 10 May 2023 13:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9DB12B78;
	Wed, 10 May 2023 13:10:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D84D20B42
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 13:10:10 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2503AA5
	for <bpf@vger.kernel.org>; Wed, 10 May 2023 06:10:03 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34A9GoZ2001462;
	Wed, 10 May 2023 13:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=P22oQRVLhijTPVFriCDI3aBY7KQKgkgizBBJcn5fJ8g=;
 b=DCXN7ZcfRdqj13P9OGqmQv8yCmV4LIve5s3XJu3El63E+xTxPLv7g5E/jAb+kLl4T0OM
 R32MUT7+OOfXZ4A3Z3DoOIkz/t7G/zkw971yAKe06kHn7AgFdVw2rAJ0ZHPd/PbUi/4C
 DCd10KKM+iqJXGqCNxoJg4AdrdoGm/2APt5EjMBG186RHkt43PxuJ2EBey6KehNQ/yfc
 v+qwP76A7499ICEDEoRAyldh6PcN2zRhYBxFosAjGoAvI3NNye5JPHPgE6Gd88tMK8Ys
 QqUo3kW5AUfla60652mqaFxHUKneaQTDi8WL0Eajx87Y7vGD/ZS+G2MBMHlCGIWMuGki GA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qf778vgwg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 May 2023 13:09:37 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34ABVnUd002181;
	Wed, 10 May 2023 13:09:36 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3qf81frtgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 May 2023 13:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MVeYMc/I2qiyuTgWOec0Z2CobzkEgJnuPiKJfPB/Zpcek/DA0a4RmTtKIDJBu/jbPiOb4cqrclYeNbXZSz7pyYcFTj6NWAFYM+bxJIVHZHKovTtUcdF8SCK9lzS8PGJzyid1DWR7S6UUFPLU6iHt0WIk+R4hjJRWkuEnddaz55Y/oRV5S9xlwOGSY3wZcnJTc9gsmlRMayCNdIyMjlpu4kQmCoj0qmnm+3r7WCkJakd6VRa1EeZxYGYYt2TlNCoFBzYTOCGMMfVUgKqVJgCA/xwDS7hT9iWvDUBUeRAnTuI9XNMCxXPqM+08AVvhtuAbZjRKrbhPXBo6IjgxtAmaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P22oQRVLhijTPVFriCDI3aBY7KQKgkgizBBJcn5fJ8g=;
 b=MrETOPnAaqJeBzdX1Wltqvbex7qsiCTa2iqlyU9He2VC1x7hsbgHMTf/y/WQcbDt1lb5AuVYI/dGm0B1UwMgjGP52fI45clt0/tSixv7mYhpkkF919Vw2QLT0XI8CtVrrldiU2eqLqqouW7kBvyME/powNk8nVjH1/V11O6EVIE10yj5WOryeNVf5HTiYCOUmXyHfNamR+rj9J69D+gwHmI5i2wOhrrFvGB+80reBqaVddKJkDZPdsI0x8EfuOEE/Dw2IcvpUqFd6i2sq69jDDieMyPnAA08I4x0TKCetlAic/LSSaWk/s1OuJgbR2FSwRVeWNH24F32vbD0GWIdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P22oQRVLhijTPVFriCDI3aBY7KQKgkgizBBJcn5fJ8g=;
 b=qmc4mrdBdp5HjcDFzpkfnih5kV1LlcL25/9X9UMEe5nX5AvGlhsRIZ+CHqFlN5NuTHZcRkfmqDiEQYAff2EgwNR8gqD8TKb1SmLDnw7Usiu9WtT+25NvNuXA7cjhVf56d2cu9bkxulI2CbuNcEf++6AO8oAVtMR3VTgt7TebK4M=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS0PR10MB6224.namprd10.prod.outlook.com (2603:10b6:8:d2::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6387.20; Wed, 10 May 2023 13:09:33 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::90e:32fb:4292:1ace%6]) with mapi id 15.20.6387.018; Wed, 10 May 2023
 13:09:33 +0000
Message-ID: <5ef0ff27-2720-42c0-d432-c21ecde0c58d@oracle.com>
Date: Wed, 10 May 2023 14:08:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: pahole issue. Re: [PATCH bpf-next 2/2] fork: Rename mm_init to
 task_mm_init
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Yafang Shao <laoar.shao@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        bpf <bpf@vger.kernel.org>
References: <20230424161104.3737-1-laoar.shao@gmail.com>
 <20230424161104.3737-3-laoar.shao@gmail.com>
 <CAADnVQKr3bmG2FfydcbXjwx5gML7NYjPiDtW+B1D+hc7hmD3QA@mail.gmail.com>
 <CALOAHbCFAV1Tvko1HWhD9CYTqcY_ojP47ZxpWhyi=Sib8+5iWg@mail.gmail.com>
 <CAADnVQKx=dnd8_jaJGcric955MfvaHqKq=WSgVKc4wAWj_fORA@mail.gmail.com>
 <0d9bbdf6-12b7-a9a3-9bf3-7f67b01c5c3e@oracle.com>
 <CAADnVQKeSmeC1RR1CJ=r4=sLrBwTH3UnPHhy-Pm_DeGOrDor1g@mail.gmail.com>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQKeSmeC1RR1CJ=r4=sLrBwTH3UnPHhy-Pm_DeGOrDor1g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS0PR10MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: 1118a8ba-79af-4941-d7ba-08db5157cc45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	qed6liRbEg0cTTZ53RioE6g3NS/mdX9w73HsnJRG5bERTfT4RdJyMqN2AIMKCflLXDOqVT/1JwKM1NKW1qwCkAuX4aJrNGGoj3Yl2FZYT6qR9XKNWyVTr8mjwUqlWQ8QBTTbTJVMhqqecZqBYPnHl/S6C1EHgC9LupW7z/iuTB1Ru+qtkPZzqTuig4z/C3vLV1MIpg1gI0TMH5myzi2zQWp7Va0hFjipzpJSjB7KhVz3aVmKrOS4eyuzQrLTHLOs8fJ1H2+HQLCBykJiXyOQ5f4gsOdCZgKtcJ0p+/d5tzof1Ag+Qed52MkQKmHhuNWa+xd0pTmXuJ5u0k7Zot8HPP5r3sWzNa0BLfX4wTcHp+3/3YLSypW9y60FH5EroIr8K0aaQ2fWNfMk2PTPtUAdJav9nqXDX2n1MlP+PKuQpuwrUwWWulb0+xrCcxP66EUAiqSr7Oj65BnODt+dYv/0Iff5Z9wEukgVlOkEP8EUNMq8ueL8Xq2Wyh7tT5uUKjG1l3RRDIgptWGiXdVzn19+oh8HVSXXnzsIJt2+aK5Niq5DkFkcV5AL+dwVtoL2gIpVR1CoWW3xVRA0h4WtFFtsgPPRttGVWO+9XR7PjjIY8YflMI2R+/a4rhW1muBiyZ9wsPf9Nr8DOZhD5xW7hNNfkaeOksB7dubRP250QU3kpof/lXgrZ6MpJJkrMecHOIyn
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(396003)(366004)(136003)(451199021)(86362001)(2906002)(36756003)(31696002)(53546011)(6506007)(6512007)(44832011)(7416002)(478600001)(186003)(5660300002)(966005)(6486002)(6666004)(38100700002)(4326008)(66476007)(66556008)(66946007)(2616005)(41300700001)(316002)(31686004)(8936002)(8676002)(54906003)(83380400001)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Sk1UMmFlVmVaN1NQbWRVUVhUK045a3pKc2ZuenZkcysvZXV0SjJpclJKQ3NP?=
 =?utf-8?B?RnpiTmhjL3JSWmhsdnRPM250Yy9yeFNmeVNYaVppNDQzc1pnRi9yblNxaUEy?=
 =?utf-8?B?bVp2S0xHcmJLRWlLUnFuZG0vOGVMUitRYUY0YWttbUdWWnoxclVZbjVBNG1D?=
 =?utf-8?B?NkROTThZcG9EbEtJKzhMUFl6c3VVZ1RMdXhFaTVXc25wRVJXczZGeUNuYVln?=
 =?utf-8?B?QmwzVFhvWVhTS21nMG9leStzb0RrQ1hmVy96VXVpcW53RHZTc2JrSXU3Qk1X?=
 =?utf-8?B?YzUvQkZISVNBV3lseFNhK0gyQVZkSWJaMS8zOGVxQ3hrMHl1a0tNNnNid21E?=
 =?utf-8?B?Qmo2Zk15RlFta1VzTWZWbER4TUczdm1NOXlYeVdtRFZleWlsY2lGVGtTTVlJ?=
 =?utf-8?B?UHdZYlRZVkV6bHUwY0VhaURLUFdRejlkTkZyZGI1UkJBcnZrMDdIekNVREJX?=
 =?utf-8?B?TlhVMkI0SENtQmtObWtpS1oxN0h5RjBubmF2YzhkT0dsT2FZZnpVN0hVUUdP?=
 =?utf-8?B?dWlSTjRVUkJFVDhpYkwzOUZtUXM3K2pkTWh4OHVRNkxFTFBpVWJDR1MrTkpE?=
 =?utf-8?B?RFFHS2FlUGo5L1hxRW1meEYyWEdLQlY2a1dDaTE3UmJ2dTIrRWJqL3dvRThG?=
 =?utf-8?B?Z1RSNmpUamhoVTBxY2dKKzBLY0ZLbm1sYUFkZ0pjWlZRRHN3dXRSSmdrcVUr?=
 =?utf-8?B?RXZVa1VHTnIxYmR1ZURKQSt6Mm91MWlKOFlhdHBsVnFPN2x5QkVCVHk3S3U5?=
 =?utf-8?B?TlNXVTZ3Yjh2dEltbzN4UysrOUYvS1pSQWV5VWNPUUJvemk2L3h3dWVLbUI5?=
 =?utf-8?B?NmdBekVyWUdTamEvcHF2QlpwcE1kS3VCSHpHR1c0NlRaMzBweGpXRDBPOEww?=
 =?utf-8?B?di9ySWViNWRjQ0xlVVJjOWVxdGRCcTdpdzAxcmxjbGxKeWJsdC9sNi92ZHFv?=
 =?utf-8?B?SjZnQlhjTXVjYm5QM1h5SWFSWU5IQSsxVnFyMnpGWlhaSnRNRlgzRDdRSThl?=
 =?utf-8?B?RzhrUG1hZ3RvUThRaGpSYlNWRXNUT2swYmdUek0wUW5sSU96R21IL3BkVlIv?=
 =?utf-8?B?OG9hTW1ZN0c2QWdLK3k4c0hybG5pRkRSVGFrSUFLMGE1SjJRM1ZwZFBIazkx?=
 =?utf-8?B?S0NiQUJKMzZRTjBidGJQdE9TTGRhTmhRa0F2elJZSEhtQ2pHUGJER0w2WUpw?=
 =?utf-8?B?R0JzMTVDeXE1QUg2d3hnRXhtclVnblBLWmYzd1kzcWpxNXV6VjlpamkvazJQ?=
 =?utf-8?B?N0dMNS9uRUZad2ZTaEpLVll0elM2dGtVVEY0TlNqZXVDT2l0b1FKV3VGZVBK?=
 =?utf-8?B?VDY5YU5PblZBU3N1dnlRd2hCNnRha3E0MmUwLzFYdGRJS054dy9hNTBGZlRL?=
 =?utf-8?B?cEhOai9EVnl2UGU4SVZyTnFTYVFhWkVqNGJLYWUyQ2lhTGl2a0RKTy9oMzBX?=
 =?utf-8?B?L3JsRnhtWnVnenJJelJuQ0NNcXhPVjY4M3pyTkhYOWJVMEtFS1hmTXhmZUc3?=
 =?utf-8?B?VDNkUDRkV3l6eG85MHg5dklvd2ovSUhFSkpsWXF3a281MzAvei8vYU9pT3Fu?=
 =?utf-8?B?cG42a1pVV3ZKbXc5aW53TkxOa0lkSVJNb0NTOVVibUhmQWpZTm9sb1ZGRlgv?=
 =?utf-8?B?OXFIREtPajdLWUk0Q0JSV2VXOEFxenJvdU5MYUw4YTd4M2Rtdmh6eDZMVGtt?=
 =?utf-8?B?bXMzTTBCWTFYcmhvZGNCakV6YWVWZ2llWXZGWXJncE5ocmxQOVZLUGU4dkhz?=
 =?utf-8?B?TTl6ZXBFRUdGRjcxQ3IwblZDTXg0aFFORXdKMzZ3THczV3o4M0J2NEhyMVFZ?=
 =?utf-8?B?Q2V5NUJkb3dKWEp3VUhFZW9mUlgzdDhvdTF3dVgxYWdheTJzZDk2aTRjTzNn?=
 =?utf-8?B?N3J1THIyOWNNTDAwK2xVSG8xUlNkWVNqL3UwaXBkSHRhWGJzSkFkbUM5bVhl?=
 =?utf-8?B?cXVuS3pDVThMcXlWVUN5cUI1QnNHZCtYT0p4TVplWmdpSFo3Rkx6emU5TGZD?=
 =?utf-8?B?YXArV2pNckNDVmlxU2FlSlZYQUZZbzArL3QrYjVMazB1aWl1NThtSnI5L1J2?=
 =?utf-8?B?TG95Rld0SFpibllBZCtYTGRLQ1JFRXVNM1V6WmhVZ2J2Z0xqaGZPTUNkSkRN?=
 =?utf-8?B?NGpNQWZPR21teHorNGVUSmt5VHd1eGRjblVNVXN2Ymh5WmhkclZ2YXUvam1I?=
 =?utf-8?Q?5+hU6w5B7k2buW9nxjl4vxI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	1g5kj1yhx/dXfU41plRl2RpavcwJoDFqDkoBYrrVe+nOi0tGHnaN0PT+nbX5E3158dvfTGfWJ4cbqovi/DXsTZIcH7N6GVWAh5BiZAg1ekeIsRHYBnO8BuDTHS3T2AgKboO5etbdBlg8PShYIre2wzX6h81/oEzoMS65nXs6gnaYMixbGE99Sr7s3CZYeI2zkL5g56//AjsP7ROLvlYxvS5APM+iw+d6T5dvOv9/StVPAMp208bZwX67oXahkEUKzp6S0w18X2A1pGdJd3U5TPoX/+FqZfPKail4eARxguaSukkfwrt71rfIrP/UVuTfS6zzbLYOAL8Iq9dqdwHhhim1jJhKXxCK7KCCi7PL8RCrEcIMQuO8rlnMvkNJmlSAGRXFe2JViIarfMkTPGylgwcCq7V3BR8baId+u6BEnL9bgy7LT4J9D4mHo9fc2SlVjp4IDI/ihveErWrvndu3ZF9HKR36UpcMvE5Q6ojltTbO7z55p7NbUrt0QIIjlsGaP6f+nULA4g92oxJmaK8unBaO80D3AnNH73MVm2CjMd22QMVPAXphEw6rLCPgoBAdrlQyZq7UAk4KffsVYo7H35pZPsbRAQfSpriR/QqeQZpmhM+AeuM0O+o8rtdA6hm6WehDuUn3rhE2v/T0I77PXBgh19glRPexqe8bl8vahwl1fP9wVIluWZeX0ifFUltci95BwtGBgM7ghO1J8eVzT62/QpY671kYBW/ZCI6XoV2WfAAGspQbRHpGqe2VzSYTLTzMGXChCLToY89JZR7eKh0ISMA97VpdAaGsj2jsAWM9f+EP1PZo2P0bhpTNirRksuTx+lsUKteHOMh7xFYNDqTMEXSjyn7tKZjKe+1yNwxWmMnGlfW1wmHbMdyq04VfGv1dJ4DTZgf2XXOUapl1Ig==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1118a8ba-79af-4941-d7ba-08db5157cc45
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 13:09:33.5691
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EY4T/EQuxG8u9FkAQrK79XfbhgZZ7rYD1heg5dtVxH0AP1klFOHKVH5NgM3ViU0/9uavVxD93hp9zxLLp40s4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6224
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-10_04,2023-05-05_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0 mlxscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305100104
X-Proofpoint-GUID: 3j89Kj_aDnrpZQYAeZzUwnCUoZtcwpT9
X-Proofpoint-ORIG-GUID: 3j89Kj_aDnrpZQYAeZzUwnCUoZtcwpT9
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 09/05/2023 22:21, Alexei Starovoitov wrote:
> On Tue, May 9, 2023 at 11:44 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> On 02/05/2023 04:40, Alexei Starovoitov wrote:
>>> Alan,
>>>
>>> wdyt on below?
>>>
>>
>> apologies, missed this; see below..
>>
>>> On Thu, Apr 27, 2023 at 4:35 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>
>>>> On Tue, Apr 25, 2023 at 5:13 AM Alexei Starovoitov
>>>> <alexei.starovoitov@gmail.com> wrote:
>>>>>
>>>>> On Mon, Apr 24, 2023 at 9:12 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>>>
>>>>>> The kernel will panic as follows when attaching fexit to mm_init,
>>>>>>
>>>>>> [   86.549700] ------------[ cut here ]------------
>>>>>> [   86.549712] BUG: kernel NULL pointer dereference, address: 0000000000000078
>>>>>> [   86.549713] #PF: supervisor read access in kernel mode
>>>>>> [   86.549715] #PF: error_code(0x0000) - not-present page
>>>>>> [   86.549716] PGD 10308f067 P4D 10308f067 PUD 11754e067 PMD 0
>>>>>> [   86.549719] Oops: 0000 [#1] PREEMPT SMP NOPTI
>>>>>> [   86.549722] CPU: 9 PID: 9829 Comm: main_amd64 Kdump: loaded Not tainted 6.3.0-rc6+ #12
>>>>>> [   86.549725] RIP: 0010:check_preempt_wakeup+0xd1/0x310
>>>>>> [   86.549754] Call Trace:
>>>>>> [   86.549755]  <TASK>
>>>>>> [   86.549757]  check_preempt_curr+0x5e/0x70
>>>>>> [   86.549761]  ttwu_do_activate+0xab/0x350
>>>>>> [   86.549763]  try_to_wake_up+0x314/0x680
>>>>>> [   86.549765]  wake_up_process+0x15/0x20
>>>>>> [   86.549767]  insert_work+0xb2/0xd0
>>>>>> [   86.549772]  __queue_work+0x20a/0x400
>>>>>> [   86.549774]  queue_work_on+0x7b/0x90
>>>>>> [   86.549778]  drm_fb_helper_sys_imageblit+0xd7/0xf0 [drm_kms_helper]
>>>>>> [   86.549801]  drm_fbdev_fb_imageblit+0x5b/0xb0 [drm_kms_helper]
>>>>>> [   86.549813]  soft_cursor+0x1cb/0x250
>>>>>> [   86.549816]  bit_cursor+0x3ce/0x630
>>>>>> [   86.549818]  fbcon_cursor+0x139/0x1c0
>>>>>> [   86.549821]  ? __pfx_bit_cursor+0x10/0x10
>>>>>> [   86.549822]  hide_cursor+0x31/0xd0
>>>>>> [   86.549825]  vt_console_print+0x477/0x4e0
>>>>>> [   86.549828]  console_flush_all+0x182/0x440
>>>>>> [   86.549832]  console_unlock+0x58/0xf0
>>>>>> [   86.549834]  vprintk_emit+0x1ae/0x200
>>>>>> [   86.549837]  vprintk_default+0x1d/0x30
>>>>>> [   86.549839]  vprintk+0x5c/0x90
>>>>>> [   86.549841]  _printk+0x58/0x80
>>>>>> [   86.549843]  __warn_printk+0x7e/0x1a0
>>>>>> [   86.549845]  ? trace_preempt_off+0x1b/0x70
>>>>>> [   86.549848]  ? trace_preempt_on+0x1b/0x70
>>>>>> [   86.549849]  ? __percpu_counter_init+0x8e/0xb0
>>>>>> [   86.549853]  refcount_warn_saturate+0x9f/0x150
>>>>>> [   86.549855]  mm_init+0x379/0x390
>>>>>> [   86.549859]  bpf_trampoline_6442453440_0+0x23/0x1000
>>>>>> [   86.549862]  mm_init+0x5/0x390
>>>>>> [   86.549865]  ? mm_alloc+0x4e/0x60
>>>>>> [   86.549866]  alloc_bprm+0x8a/0x2e0
>>>>>> [   86.549869]  do_execveat_common.isra.0+0x67/0x240
>>>>>> [   86.549872]  __x64_sys_execve+0x37/0x50
>>>>>> [   86.549874]  do_syscall_64+0x38/0x90
>>>>>> [   86.549877]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
>>>>>>
>>>>>> The reason is that when we attach the btf id of the function mm_init we
>>>>>> actually attach the mm_init defined in init/main.c rather than the
>>>>>> function defined in kernel/fork.c. That can be proved by parsing
>>>>>> /sys/kernel/btf/vmlinux:
>>>>>>
>>>>>> [2493] FUNC 'initcall_blacklist' type_id=2477 linkage=static
>>>>>> [2494] FUNC_PROTO '(anon)' ret_type_id=21 vlen=1
>>>>>>         'buf' type_id=57
>>>>>> [2495] FUNC 'early_randomize_kstack_offset' type_id=2494 linkage=static
>>>>>> [2496] FUNC 'mm_init' type_id=118 linkage=static
>>>>>> [2497] FUNC 'trap_init' type_id=118 linkage=static
>>>>>> [2498] FUNC 'thread_stack_cache_init' type_id=118 linkage=static
>>>>>>
>>>>>> From the above information we can find that the FUNCs above and below
>>>>>> mm_init are all defined in init/main.c. So there's no doubt that the
>>>>>> mm_init is also the function defined in init/main.c.
>>>>>>
>>>>>> So when a task calls mm_init and thus the bpf trampoline is triggered it
>>>>>> will use the information of the mm_init defined in init/main.c. Then the
>>>>>> panic will occur.
>>>>>>
>>>>>> It seems that there're issues in btf, for example it is unnecessary to
>>>>>> generate btf for the functions annonated with __init. We need to improve
>>>>>> btf. However we also need to change the function defined in
>>>>>> kernel/fork.c to task_mm_init to better distinguish them. After it is
>>>>>> renamed to task_mm_init, the /sys/kernel/btf/vmlinux will be:
>>>>>>
>>>>>> [13970] FUNC 'mm_alloc' type_id=13969 linkage=static
>>>>>> [13971] FUNC_PROTO '(anon)' ret_type_id=204 vlen=3
>>>>>>         'mm' type_id=204
>>>>>>         'p' type_id=197
>>>>>>         'user_ns' type_id=452
>>>>>> [13972] FUNC 'task_mm_init' type_id=13971 linkage=static
>>>>>> [13973] FUNC 'coredump_filter_setup' type_id=3804 linkage=static
>>>>>> [13974] FUNC_PROTO '(anon)' ret_type_id=197 vlen=2
>>>>>>         'orig' type_id=197
>>>>>>         'node' type_id=21
>>>>>> [13975] FUNC 'dup_task_struct' type_id=13974 linkage=static
>>>>>>
>>>>>> And then attaching task_mm_init won't panic. Improving the btf will be
>>>>>> handled later.
>>>>>
>>>>> We're not going to hack the kernel to workaround pahole issue.
>>>>> Let's fix pahole instead.
>>>>> cc-ing Alan for ideas.
>>>>
>>>> Any comment on it, Alan ?
>>>> I think we can just skip generating BTF for the functions in
>>>> __section(".init.text"),  as these functions will be freed after
>>>> kernel init. There won't be use cases for them.
>>>>
>>
>> won't the pahole v1.25 changes help here; can you try applying
>>
>> https://lore.kernel.org/bpf/1675949331-27935-1-git-send-email-alan.maguire@oracle.com/
>>
>> ...and build using pahole; this should eliminate any functions
>> with inconsistent prototypes via
>>
>>       --skip_encoding_btf_inconsistent_proto
>>         Do not encode functions with multiple inconsistent prototypes or
>>         unexpected register use for their parameters, where  the  regis‐
>>         ters used do not match calling conventions.
>>
>>
>> I'll check this at my end too.
>>
>> Alexei, if this works should we look at applying the above
>> again to bpf-next? If so I'll resend the patch.
> 
> I've lost the track with pahole fixes.
> Did Arnaldo re-tag pahole 1.25 or released 1.26 with the fixes?
>

My understanding is the pahole repo is prepped for v1.25,
meaning that it will build with version 1.25 but it is
not officially released yet; Arnaldo will correct me if
I've got that wrong.

> Alan,
> please submit a fresh patch for bpf-next to enable
> --skip_encoding_btf_inconsistent_proto, so it can go through CI.
> I cannot test all combinations manually.
> 

Done; see [1]. If CI picks up the latest version from
the dwarves repo, it will see version 1.25.

I've tested the above specific case along with general testing
using latest pahole.

When running pahole with --verbose and
--skip_encoding_btf_inconsistent_proto

we see:

skipping addition of 'mm_init'(mm_init) due to multiple inconsistent
function prototypes


...and

 bpftool btf dump file vmlinux |grep mm_init

shows the function is not encoded in BTF due to these inconsistencies.

Thanks!

Alan

[1]
https://lore.kernel.org/bpf/20230510130241.1696561-1-alan.maguire@oracle.com/


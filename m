Return-Path: <bpf+bounces-7100-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E90F3771575
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 15:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A05742812AF
	for <lists+bpf@lfdr.de>; Sun,  6 Aug 2023 13:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D265241;
	Sun,  6 Aug 2023 13:50:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5034C28EF;
	Sun,  6 Aug 2023 13:50:35 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2074.outbound.protection.outlook.com [40.107.95.74])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B661EB;
	Sun,  6 Aug 2023 06:50:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NrzEpZhANu8nhSvGSUeooGrHik2fIDgKa5Ue5skayFQyhxBzKm7R5l79t9vuU2EzSjGRV2xw1kpFSLcwzoRhCUE+whcI4L1Pb8Q6e6BrusNjIqiJ5eg5ug381QJQla10DuReL1vZXfJYfKSZxw/S2yE/ym5qUh1R9uUSABsvGOtktSpSC0WSxljThXCB8quRZIOKgP9rI7BwmKPgTC/OLDzEFQhNReX57B/SVU++SQWZcdVfNg1uqZz0uFy38cyyX/BUDb3gpyvd8+StRbtFo3iwXAHsxJoD4NxfAQv3YNqcg5i2Lg/Z162Fk4pnZCJF29rhqDZX6IVmPbhjalHGZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpdt/QWh6coGw0bD/0QhDbRoeN6AB40JtkfzARXs7aE=;
 b=Rs5WLvW/h3SAXUw9aV2tiormUv3ipm26r4XH6TlNqp/g5HeYW/+pi9mFMQ8r+wNTrq/E00jo095/ZIIIm4sJCMgIWftzj0wGFbp16oq8QwhQ4+1awhIVElmhAGH94Tg0YbcZGJodSVl0aEH+C0vxkmq75LjYWfqctGzy0m5iV0yCadyyNLVe/9sQGc9PBGAN+RaAWJVbhEE9PF8iujmBDgy5HjJoNMu8h7pm/nF43htrmsbCpscVOl21KGGtNmw2bLmsAzNQgkMGLajesvbPnuGURmchJlHldCSScJQUK6205LSg7iDHILp0tQxbaGYfj28Rece0DFdITuDJ+f5ZKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpdt/QWh6coGw0bD/0QhDbRoeN6AB40JtkfzARXs7aE=;
 b=PxCsAII7rdWGty/xOvhd1sMXQ8MLu+F+g6kQHC8TLoy50piMdnCAolRfCjWqdMctPTk3xUmlz52rAC81efPhhSZjym1ibsZCBIHFypcOE/OkxVIP+Qmhdy74X5RxP0/jUNwtM+vUXLRzUYWyZMu6PHZBf8TtoPIh41GQaAuJK96W8kagtqUx5Tpbpn4Pv1co9ULFTPKiNuokt76RDrblVwISRdqZnlcVuIin9UfjHbg0uZvfx5jvwPyfRZKNO96WpvX3OloNLOgciwTt6zrgWylW6ollMfXOZZ6wKYiY9Dh5/hNsl7q2MBv5LW+SutRol9icMlTr7ADrbdUn+2kb5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB6288.namprd12.prod.outlook.com (2603:10b6:8:93::7) by
 SN7PR12MB8104.namprd12.prod.outlook.com (2603:10b6:806:35a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Sun, 6 Aug
 2023 13:50:26 +0000
Received: from DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b]) by DS7PR12MB6288.namprd12.prod.outlook.com
 ([fe80::2666:236b:2886:d78b%7]) with mapi id 15.20.6652.025; Sun, 6 Aug 2023
 13:50:27 +0000
Message-ID: <e7007a56-7e4e-b5ce-bcfb-4e35e7025a4e@nvidia.com>
Date: Sun, 6 Aug 2023 16:50:18 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next] tcx: Fix splat in ingress_destroy upon
 tcx_entry_free
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>, kuba@kernel.org
Cc: ast@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+bdcf141f362ef83335cf@syzkaller.appspotmail.com,
 syzbot+b202b7208664142954fa@syzkaller.appspotmail.com,
 syzbot+14736e249bce46091c18@syzkaller.appspotmail.com
References: <20230721233330.5678-1-daniel@iogearbox.net>
 <bdfc2640-8f65-5b56-4472-db8e2b161aab@nvidia.com>
 <96b33f76-de8e-54ce-fcef-47924d797013@iogearbox.net>
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <96b33f76-de8e-54ce-fcef-47924d797013@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1P191CA0005.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:800:1ba::12) To DS7PR12MB6288.namprd12.prod.outlook.com
 (2603:10b6:8:93::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6288:EE_|SN7PR12MB8104:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f3f6efa-dc66-43ba-bed9-08db96841773
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xwYqQxDluPXii/JNfas+4hiYqH30891jwW8CczgFE7W7mDnBsiEItKCTWEGGF5168GvIo1a1jVHZyOipeSQb/ncnGhG4oFEjWvGcsaz/WxLN1rBDFuIoKQfIYJ3oYFB2MWubHNesGYU7WZr4gp2EZtbtMMB7amtH6XeL6G0edtBqbhU/iEAdE7WjQQXftd3n/zJj8n07Hzz3Utj3IyRdw65CfWaJuBuo/exNC2lhMm6YsU9H0/vNtCCELOAsRFhINDBUn1yGgtwM5poew/f957U0+g/Hgzrmgpxb6Byuh0r0sM0H5wAcyBauhSyDB10WZrrvFa/nfNgaXFAaVpv5uOBcmbZs2VwXMPuX7Wrqv79SBp3VrFGsxNkmaW8Iha5bvBFprfSTTolc6acxGXf8drPXASVb748iarGLTPTFt6Ac7vTV9whs3dhYD+Ea+6zq1CEhAldYWCbGteZAPg1ojhe9IgXCTfQQIsryozyZTCVbRMwnJZcolfyTf90MNziJmWgqLE8uqzQgRoQ5k5xzc+he2ZuLtYysQAbzPExKObWbXVBtItIRGulXRCi6iqhl/15FKxNjH3nCAsMHbIt2q5txiNEsivHNx7llX5VJQ+b44oeahXVgh0GH6gEfQRMmgwvmFLkjGFRlAkbBi2J+4g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6288.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(451199021)(186006)(1800799003)(31686004)(83380400001)(2616005)(38100700002)(2906002)(316002)(66476007)(66556008)(66946007)(4326008)(8676002)(8936002)(41300700001)(4744005)(6512007)(6486002)(86362001)(478600001)(6666004)(5660300002)(53546011)(31696002)(26005)(6506007)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NEJ3c0FDL29nejZoOVNmei9MdjcveVM5V0RCNi9acWUxc3c0ZnF6RW1QbzVk?=
 =?utf-8?B?SFVidWNtMkgrSm5Lc3h3ckhMblBLT3RTdzdRdG1DN0ZGMVc3SUo1MStld05K?=
 =?utf-8?B?T0U5SVFXZXU4SmRtN1d3RHVtODJSaU1lN3FZSnd6aExsckE4dkpMYzNWR2tB?=
 =?utf-8?B?WHZhUEVDTkRmVkFFTmo2T1BFbFNmZXd3S2N6dVkyMDhlUGdFWGZOWUZuU2Q4?=
 =?utf-8?B?QVZ2SW9tWnMySmdpSE9Vell1Ly9VUFBuUUs3bEpnSVRGdys3ZHhSb2hVM3hM?=
 =?utf-8?B?UVlnTktxTnBLckI2QnZnYlVBZUc2ZjdGdmtJcnNSaVVQcmkySmtJZGZkSi83?=
 =?utf-8?B?L29rZ1dBdVg5MW9oNWNWTVhSM2xranBrY1RpZE5tNHdOMnhoVmFYZlpQZElz?=
 =?utf-8?B?a0pob2tNWGd5MTRDL0l2MGZROWczY1ZkWGZDUGFOa1hGYUdTVVA4bHE2QnBo?=
 =?utf-8?B?YU1Tc1dNQzFMdXI3MU9qNE1pYitIa05nNHhNc0cyNmNPcEFPUzhTM1ZwU2lr?=
 =?utf-8?B?QktZREdHdXk3aFEyY0MvQjBBTGlhemZKbFFFU3V4MXhzYTJMbDczTjFVN09x?=
 =?utf-8?B?VE12b1Y1U0hXZmtQTW13R1EwckhqR2RMR09rYVZZT3g3ajZ4eTRkMENncUxk?=
 =?utf-8?B?ZzY1anUrSC9xS2RoWGdOQUNRa09lUVFFNzlEZnNSL2xQOG04cWdQOERSY0h4?=
 =?utf-8?B?NjBkQ1c1RkxiM3ZNemN0bUFlWHl6RXlsWkZhU2hjQ1UyZXB1dDcySmtWU3JF?=
 =?utf-8?B?R1FtNHE4bzhvSzA2eUR3VktwR0VaSzlPc2xEQTY4TXU1SWdSZXN3SURoTGdi?=
 =?utf-8?B?RlVCSVhBRXorYmcvc0t6MTdFUFdUUTVPVGZHN2w5dU1iai9UVDhIVU5tYUpo?=
 =?utf-8?B?RCt3QzJ1Z2Uxc25FZzNzZE4weVlSL3BXdkRJZGIzRVNDbktKTndpUmFxRVRT?=
 =?utf-8?B?TUZLZmRjNTVaamFWTVZvOHV1bzY4NXh3ODZZZTJSditGdCtpbXhSQnNpRW1U?=
 =?utf-8?B?dlRWd2hiSS9wNyttaFNWMm9SSFhsN1UxNmZXb0ZqQ3dmMndKWU5jbnVZcjFY?=
 =?utf-8?B?VUhRNEtxZ09UQnBxKzY5QzZ3VUUrQjVycVYraGlIbmxwSEZVc3VMRkJCN3lJ?=
 =?utf-8?B?WXFxZlljalRsYU5USzcyUEg0YVNEb3NsQXhWdmNIdm5VNUc4Vi9XUUMrV3lV?=
 =?utf-8?B?Kzd2azlVUk9GRW9xY2tvOG1FV0tTKzE0VFlFajhBeEZqamJVd1Y5SUtiZTVp?=
 =?utf-8?B?eERmcXdKRERDamwzZzdmei9mZk1wNk0rUGVGQ1BibEpLKy9FU0VrVGs0Rzhw?=
 =?utf-8?B?QjBvTVhBOVR5NjBBUTZDR3I4MVo4WnBLTkp1ejJzTHZIQXZ0eUFZWDlxdVFM?=
 =?utf-8?B?N2JxWUI4TjQxbjY1UW83WmdNTFdXSHVKK21qeDk3TzZCTlcxdGw4aXVtbEN3?=
 =?utf-8?B?Ni9iaGgzVVM0ZkVGMVB0M1NTS1V3UDN6RHh2SU9DMWFsR3pLbEczNkN3N2do?=
 =?utf-8?B?SUpXTG5DRC81Y2Rtbkw1VnJ2RkRza1dqdUtHSGttc3YxY3ZzWTYxbUl1cTRF?=
 =?utf-8?B?Wk9oaEUzdEtLU2d0VkJOOG43M3RjeHFSTExHN0IyaDFTREpKNGNoS291dE96?=
 =?utf-8?B?Q0xNUTZ5MjNPL0ZFMkpBczJtMXAwZVcyaGQzeGRHUElyT2EvVnhGV0RYZTVP?=
 =?utf-8?B?ZzVBU29CWlZUcVlLYm01eE5iM2hUTHJ0cmpwY2kwOHp0V2ZCSU9lb1huanEx?=
 =?utf-8?B?SkxmUkZNZkFUcVdDQVo3Ly9VN1dDY01UTy9IUzdTMGh1NmVFZW00ZWVNQU9C?=
 =?utf-8?B?QnZZbDB0YVR0MDZIQWlsL2xwSFV0QWQzUy9mNkpnQXlMY09nSUYwSlhydU1u?=
 =?utf-8?B?VVhaT05QSUlFbmFHTFE0TG50T1M2aS8wSG1INmxabmtLSDIrdnFubVRSSmlO?=
 =?utf-8?B?R1VxVVpQTWlvVFdJQmZhaWkwaGhRYVBSZU1DeVR2aWltM1dxVmZsTS96MWRO?=
 =?utf-8?B?UHIwdzNGNXd6d2lZTnVRdlRYcmVwcGZpZFZyUG9rMHltdEFCNitoUzB5SXdS?=
 =?utf-8?B?VU1MdFFhZDFPQ2JDRlRSVVRqYVFtUEhpRWo5bnFSTDhPM1c3M1U1LzNNNGsv?=
 =?utf-8?Q?Kugm5u1B5fgb7BPjG/2tlM5YR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f3f6efa-dc66-43ba-bed9-08db96841773
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6288.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2023 13:50:27.9077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mB34o+kAf/l9+zUkZs2+z67zz4GnEWNwgQezbOaW8VXaNUcUDSubNr2f8cgtHOjK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8104
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
	NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 04/08/2023 2:54, Daniel Borkmann wrote:
> Hi Gal,
> 
> On 8/3/23 1:10 PM, Gal Pressman wrote:
> [...]
>> Our nightly regression testing picked up new memory leaks which were
>> bisected to this commit.
>> Unfortunately, I do not know the exact repro steps to trigger it, maybe
>> the attached kmemeleak logs can help?
> 
> Is this on latest net-next? Do you have some more info on what the test
> is doing? Does it trigger on qdisc cleanup only? Also, is there a way to
> run the regression suite?

I don't have more information ATM, I'll try to figure it out if the
other fix doesn't resolve it.


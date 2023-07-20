Return-Path: <bpf+bounces-5549-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4E675B9D5
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 23:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A6A1C20443
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 21:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BAD1DDCB;
	Thu, 20 Jul 2023 21:50:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E051DDCA
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 21:50:38 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFD42735;
	Thu, 20 Jul 2023 14:50:36 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36KLMcHG002171;
	Thu, 20 Jul 2023 21:50:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=FQOZmaVmfAybrxkenhZd1HvD9KioWiSiJCo1CNLABSA=;
 b=qSmGSkto66i5K73Yg+1lvpc2CHwRH3PP4uYDMD6X3ove/yboWEYH3z5m+zCXiF/uAGWc
 r/XzuShUna/ffejEIbhGUS13PlhvYQe/Mv2q/vnEB+2TAIh5ou9LEsUEzGl1l45sUBaq
 6fnF8d7m9PU/ne8jJH0CbLyyrMta20oe/ijwVxdmdeuXoErUDbbGaD39aPeU+/4zejGV
 tw8xZRltMh0NeAIlfGtyOUGQAhRKM2sGPV4a94a6UbYLR05Xgkf94kR0y5WZY3ZAa2NZ
 jUiiGzUBlVCRUsruVq6xMMCeNf7/r/UJlGR0oIlu89jhhtazjufEDRxwoeyIxPO6vhYj yQ== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8aau06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 21:50:26 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36KJwRfF017397;
	Thu, 20 Jul 2023 21:50:25 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhw96y4a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jul 2023 21:50:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YjrqRJxYyt90gfpmgJ/+yjbrgVVvnet+WUYeiJf5OQJ6FXFrvOxeuRbB+nDWuAKdEESl9JK5Wfh9Uq8LTjCU/WItOMi68EGHCySXNQN6e8dTJWS3b2QCIBlPUF3w1KbnX0YTytqqqTPOiLA7npdlzyBGiOyQhJaYp6sypjZ5zcyGyRutSdWDW2WHWcUsWMwMYPa04I19zXvnXH+RJ9Ar8SiswXW7dvMoHCpJE0ScpTzd15Zxff9BIXegXiI4bfsj9cBkxBXkUka7QIb5UftW5cyz4puf3aNOfbwVqkZ7jJvmr+7maZzXyS5pqIo+oCnYagweeXjO82aLfEZUkcr2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQOZmaVmfAybrxkenhZd1HvD9KioWiSiJCo1CNLABSA=;
 b=ZuJCNFTDaV02HCh+6FF0Ydf6wTbBx6EK8pNsk7ZZ+24MkO0V1uA5A8h1uHQ1nvVS4AnWQwjAyvdAPRC/EY6ccj1wp2NKA+bQY1JkqTSpSM2IMlvCcr0ZHgHzJ5J+6ibzwY9IC2SrK7u9YzjhfKjJPAgH9po8oU7cWfkias01HJlCxVtk6JKEkAdUFK8RjcTX1X+c1ot4qwkOSpgZ+AWVdV91a1ZwzGt1f2PU1DN0tDNpGEa2DkwSH7CFp989WPjUoFUomOkHexwXt+xa6GzkjjpOdsdsfMLpMFg+rlD6TtjuhmKLz89Ls2e/th1nNvnzyDamryHAci1i+6lwJO/H9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQOZmaVmfAybrxkenhZd1HvD9KioWiSiJCo1CNLABSA=;
 b=sdCsbW+WolHHEc2jlMuUUnWB0FYAyS127Y5SgOEkG3fkftwBi74+LJjP+GCs0JSQ8uQXn05Yqp8rQOt96MI9F0r7De0cuTfEJAJtOx7xS97ZjGWUWcpM8RCnXqpMQLg+JC82MbmQGCthWFc4t5YlLWvuyzTUpC9dkwB3CxY+pQg=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by CH0PR10MB4953.namprd10.prod.outlook.com (2603:10b6:610:de::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.28; Thu, 20 Jul
 2023 21:50:23 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::97e0:4c4b:17bb:a90f%4]) with mapi id 15.20.6609.026; Thu, 20 Jul 2023
 21:50:23 +0000
Message-ID: <1f26e0a2-413c-f176-3cac-2947b20eb6a4@oracle.com>
Date: Thu, 20 Jul 2023 22:50:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 0/9] tracing: Improbe BTF support on probe events
Content-Language: en-GB
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>
References: <168960739768.34107.15145201749042174448.stgit@devnote2>
 <e002b414-0e12-0ee8-08a9-2a2b2f21c7bc@oracle.com>
 <20230720010144.a2a70b1db0f636401e96909a@kernel.org>
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20230720010144.a2a70b1db0f636401e96909a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0382.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::34) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|CH0PR10MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: b0c0ae12-7c2c-4990-5f01-08db896b51e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	kfvwiL8xKqGs3MgjiTeQyGIsBc/zxv/kkgXoED9J1LhEEUj23qMMk7buT9pQQTsKnWetAvdb01QxRgRxln85BxLsogAN34p7gqchVrwUDm6RoR8sbKW02l0b9eYon5S7zkKWVcV01HBwlN4NuwVxSWK5o0AIxsErSiyM6VP5jlJMPj6cOf/+HqjGLWl1xfoGj8LDbJoB6I1KrsPLaDBIUdHOrjmzf1tejiWM1Ccg5S1vg0pTYU5lsIcV8rtF7YDdh84AMQNHFL3KZ9WtpCLFYyyVIumwbwhi6Ziya+DuG35ccAOPqCP57wBq+A6xEsLrpGiWcxUFhNFkUHZQaiW2t3aUixEV4+hBS0nhR+NcsPvr5cHjaVLtONiqf+0DK4fLa9LY7geDoG1XdsjpJS1te6bjSA632BE54AOwS3F3tnCVnTCgIQiRr/S2TX9+KueTPEPoLwaHLaEYuJWUikjLvLjG11qh8hfZdLUoQKipRXI5e0BBxoQnltroG70dAQ6+IEBPJqBoazyutvmn7Nu0EG9+gBEISCZkainfDRbt8M0PTMzuxfemVKj0TvTt8f/i/TZq35w3t4GAkk46T4b87zxxL1KoP/xac0P0euVSOtMyNtsDMRcus9ZozgxLhMJB+sCgwoicn8mQj1eeLPvpIT5jrCE32/5uXosgghKj6qJQCEBSxHfe8Dc67Ty67WzJ
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(136003)(376002)(366004)(39860400002)(396003)(451199021)(2906002)(66556008)(66946007)(66476007)(4326008)(6916009)(6486002)(6666004)(478600001)(31696002)(86362001)(6512007)(966005)(54906003)(83380400001)(36756003)(186003)(2616005)(6506007)(53546011)(38100700002)(41300700001)(8676002)(31686004)(8936002)(5660300002)(316002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?b2U5RzVyaE9JeW9GelR2c0JWN21qRS9MaERnMjJuTUdYR1VHUkJRcnVWYmFJ?=
 =?utf-8?B?OVpGVjZCbU1vd1o5cHhPamp6ampGUlNqWjhPMExUN1IwMjlyenQ0dHg2OG9r?=
 =?utf-8?B?My8vaTFEN1JrZkpzWmx5UkJ0dmFiSCtmZXplMkMzcXY0KzEzZ0hMbnBONFVT?=
 =?utf-8?B?QStxT3BUdkRyNy9XZnB3OHpmZWFLanJTZWZTY1UxM3dzVlFxMW9pdm1MV2I1?=
 =?utf-8?B?eFBMMUpVd1FwQ2JZcnNWSStKMEZsMElTMU1YQ0FPbmd1eFJGengxSXRrVkQ3?=
 =?utf-8?B?cVErYS92dGRNdExMOFRMeG5wb2sydDF4K2ZTeXVsRmNFbU5IY09PV2hLSUxu?=
 =?utf-8?B?OUswZngreVNlc256QTFuQXlIYXJhRE5oRHovRnhKMzNQRVBHMU9kTXpiSm5j?=
 =?utf-8?B?dTFqSTlXUTU0akJMd0VqeGtzVjF2ZFNmdmVxank3REdXdHd3SGw2ZWZITlhW?=
 =?utf-8?B?S3lOUHFsU3dLWnNRNEM1RHhadEtwTG9ZSXRveFZGZG12a0RMU2FzWXF3Z2hZ?=
 =?utf-8?B?VWFpR1V2NmhUS2JIWUxRL0VIb2JjdVdEZFNmTWVMRnovVzM4NDF0TElNMzcr?=
 =?utf-8?B?anliamxDVUxxQjQ1RHZiYkxkT0pWYU80cTVUMlREZS96QnhMTUs2STU1YTdY?=
 =?utf-8?B?dW1CNmdGOWJSZllwS0twR0lwU2liUFk3TlowdkJoQkdQUGNCVmtoajNoQTJM?=
 =?utf-8?B?a2sxYnlKOXc3dGtTNGtjOGRUV1JwbzBwRVA1b2MvbyswSzdQZXZUK2ZMN1R6?=
 =?utf-8?B?amhuZFhrTXc4VVRkUHAvZ0hIVGQ0OUN0NmhrVUJrRHJ2L1FucS8xVXJmSFlK?=
 =?utf-8?B?SkFHUTBCeGVwam1wYms5TzlUcmVrczJWSkowaHlrdjZDam12d3p3TmpvcVUv?=
 =?utf-8?B?Z0xmUW16Uyt1ZXc5dm9TWENGZlYwcE5Zd2h4UkJRTUF5eDlOaWI5R0RmZFRn?=
 =?utf-8?B?cGNZYlRkeGMxbGozNlY2UWlMVDd6YzJ4UVd6azZPTFdFeVJmNi93YVMzWHhL?=
 =?utf-8?B?anBsazB6aTJwMWNZb3JKOStWYjdDM293QTF5WEJLSzJ3bzZnczNDNjF2cUl1?=
 =?utf-8?B?Qy9ZZXk1WjY5d1FldHVMVk5SWDh0UnpiOVBvMEVxOHlOTHpwTFNoTTNleWgz?=
 =?utf-8?B?VUZGRU9yYVNHc0lkdnVzckwwL2lFQ1lsU2kxV2JEU0hmd29PNUhoWk1jZ0I0?=
 =?utf-8?B?WGsxeXB5WlFQdHQyK0ZlRjFBNnJkbjVxSkU5RWZISmVUdUlSckwrYzZGZVd1?=
 =?utf-8?B?NWh1bUpPamRaeEZyVVVzQ3RTWmFwUG91RC9tWk9vSGE0UGFzRFF0M245VU9i?=
 =?utf-8?B?NFN4bnVzcTlWOGsrdFBJQlZpMmNPSEZJVnFDN0Y5cDIvenVGSEFYdmo0OU16?=
 =?utf-8?B?a08ycHByTFdmYVJ4c3RYS2R6TitJMllnVThaU1hJSE9wWmlqRzluQWUzb2JL?=
 =?utf-8?B?a2pRYUtFaVYvT253ZExmOFFCemE3Ykw5Nkh1ejczWmQrNkl3Z1gxZHRORlRE?=
 =?utf-8?B?dEpqYWQ2alVZUSs5WTN5UmtBM010OXlQb1FJS3JDeEVBVjZsRGxPcDFCTUpz?=
 =?utf-8?B?azlad3NBYkYray9CcWl4RUdoZ3F0TWdGZUlYd3JSNVFCSGVhNFBMKzdJWlpt?=
 =?utf-8?B?Rkg3NnJZVkVPaWdsR0VBWTU2VzArRXArdHh5bStPT0pJTTFLclR1SnRHQmtJ?=
 =?utf-8?B?VDNJWTR6Y3l3alZ1RHVsbkk0blk2MW8zOVhrNUYyd0w3RDNXajlQOVpMcjBO?=
 =?utf-8?B?bllWQWIydjFLTDI3Y251ME4yZ09zL3hvRmNtT2hncVJKaFpjZjg4K2FpQ1Vx?=
 =?utf-8?B?TWVzWkRaR0ZqVTN4RGFEQ2hleiszaDViNGNDNDRMdlhqQ2t3V1MwNmcrM1VK?=
 =?utf-8?B?ZmI5dTB0OEVYZGhDMlFkcGNTWmVBTS82cGJDbnFQRTFEM0JxaFJuTEZRK0Mv?=
 =?utf-8?B?c2hjdWx1b0dRTFQ4bDRtQnY4aHQ5RkJDaXdxWTFOQ0VjV1JndW9ZOWJiYzBL?=
 =?utf-8?B?aG1McCtMZjhlTHhmWk0wWGQva1oxYWhSRVFJMVcyUzExVnVLbXFVZjM5SWVx?=
 =?utf-8?B?OGJTekpSQTFjanpKSGJlU2dLcDViRkMrQUpaS3ZMYnJ6bTY0MUo2aGxpNDEr?=
 =?utf-8?B?RzFiV1U3WDZyY0gycVkvZEFLYkg1cSt4V2hUZ0krUlVLam5CMVhXYXJXR242?=
 =?utf-8?Q?EnTNDzf3xLTooGVg49KcHjA=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	H7I7oPK0vpJlhqAPAj5NdjCF5gCfO9i3wO8KDToP8r/hmwczzd5CopjALcSphv3qknnqCLFFqCjbUr2BKeu+UZQ7zk5vs/qaHd5Ce2cxgaTBfnfS65T4hFpibK0CEkvqLZr5y0GK5PO8ysHzNotKyYBgRTMdVocbtdMu4GulJb0lkUoHAxHNlglBHf5OubZhObzWP9TZwo3kKvQy+8SD86OzoH+Xrap3zy+3sdFrarGSVNo+gZFnLcXV3O+DgvVifaJRRz+WBZcqObMOYrZL0dSqiu+UTp2LG3Yj2ec0gTSbK33F6vAewoRP20IxB02rnNixj4YHwxWNtHmg73mNTYNV+CvufSIZJrOy4IM7PiLiGjsaGncM0SNgN2o7Kt+0fLS6ryvQAThYR53vKJdfRW0NVMlhyCV/AyT8z0hpcR3T/+bXgKXpYISJMuCLyTW5G6wV/NvrCJh57vUgPbU9gdyQnTW4ZiCI4/fIjUogiB67esolB+CvX8r32zMZrfwTsBdJDIY/xyPA/pbZzM08+sXvH5PlZN5SsH2EecHT1IFtTxCKF6zc0T6lv9W1Mz3yQZAKB4bgUw/hShU61j/OXojEzzJafNBKmNJNgzUVthD0cofKCW+FHerC14vbhlY7H2TOaep6WpqPAe5q3iwi9GfhW8pIGil0/CvVvx8hQ/3o2os5Q3DgkoYBkjut0oop4YIrYSDbhrxAe9tiSA0HXgrX/T0/iofB3CbrubntrmGM2KPNs8lQ1+zEFCT21bY3V1PLmG1phFTSi071HNGl49icpqbrDlfvK4+cDwyC08tfcbHsodydxMmjbcM5zr8pzY7tZtklBsZ11Budwcn3pPEAfDZCmwxk2bKVl5enAdCz2ytkFcDf5U4m+xb44+IG
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c0ae12-7c2c-4990-5f01-08db896b51e2
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 21:50:23.3116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVn3lTBoLHGifP2RX/zSZ5HGMpiO9C0U7144dbs3Vq2eYnqDynRVc4Swl4ZxEafOsKlvnLdJhiWIdhbg7qLqAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-20_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307200186
X-Proofpoint-ORIG-GUID: v0BEkgM9a3KzPu5qdgo8VyTPSPr4_YTz
X-Proofpoint-GUID: v0BEkgM9a3KzPu5qdgo8VyTPSPr4_YTz
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19/07/2023 17:01, Masami Hiramatsu (Google) wrote:
> On Wed, 19 Jul 2023 10:02:06 +0100
> Alan Maguire <alan.maguire@oracle.com> wrote:
> 
>> On 17/07/2023 16:23, Masami Hiramatsu (Google) wrote:
>>> Hi,
>>>
>>> Here is the 2nd version of series to improve the BTF support on probe events.
>>> The previous series is here:
>>>
>>> https://lore.kernel.org/linux-trace-kernel/168699521817.528797.13179901018528120324.stgit@mhiramat.roam.corp.google.com/
>>>
>>> In this version, I added a NULL check fix patch [1/9] (which will go to
>>> fixes branch) and move BTF related API to kernel/bpf/btf.c [2/9] and add
>>> a new BTF API [3/9] so that anyone can reuse it.
>>> Also I decided to use '$retval' directly instead of 'retval' pseudo BTF
>>> variable for field access at [5/9] because I introduced an idea to choose
>>> function 'exit' event automatically if '$retval' is used [7/9]. With that
>>> change, we can not use 'retval' because if a function has 'retval'
>>> argument, we can not decide 'f func retval' is function exit or entry.
>>
>> this is fantastic work! (FWIW I ran into the retval argument issue with
>> ksnoop as well; I got around it by using "return" to signify the return
>> value since as a reserved word it won't clash with a variable name.
>> However in the trace subsystem context retval is used extensively so
>> makes sense to stick with that).
> 
> Thanks!
> 
>>
>> One thing we should probably figure out is a common approach to handling
>> ambiguous static functions that will work across ftrace and BPF.  A few
>> edge cases that are worth figuring out:
>>
>> 1. a static function with the same name exists in multiple modules,
>> either with different or identical function signatures
>> 2. a static function has .isra.0 and other gcc suffixes applied to
>> static functions during optimization
>>
>> As Alexei mentioned, we're still working on 1, so it would be good
>> to figure out a naming scheme that works well in both ftrace and BPF
>> contexts. There are a few hundred of these ambiguous functions. My
>> reading of the fprobe docs seems to suggest that there is no mechanism
>> to specify a specific module for a given symbol (as in ftrace filters),
>> is that right?
> 
> Yes, it doesn't have module specificaiton at this moment. I'll considering
> to fix this. BTW, for the same-name functions, we are discussing another
> approach. We also need to sync this with BTF. 
> 
> https://lore.kernel.org/all/20230714150326.1152359-1-alessandro.carminati@gmail.com/
> 
>>
>> Jiri led a session on this topic at LSF/MM/BPF ; perhaps we should
>> carve out some time at Plumbers to discuss this?
> 
> Yeah, good idea.
> 
>>
>> With respect to 2, pahole v1.25 will generate representations for these
>> "."-suffixed functions in BTF via --btf_gen_optimized [1]. (BTF
>> representation is skipped if the optimizations impact on the registers
>> used for function arguments; if these don't match calling conventions
>> due to optimized-out params, we don't represent the function in BTF,
>> as the tracing expectations are violated).
> 
> Correct. But can't we know which argument is skipped by the optimization
> from the DWARF? At least the function parameters will be changed.
>

Yep; we use the expected registers to spot cases where something
has been optimized out.

>> However the BTF function name - in line with DWARF representation -
>> will not have the .isra suffix. So the thing to bear in mind is if
>> you use the function name with suffix as the fprobe function name,
>> a BTF lookup of that exact ("foo.isra.0") name will not find anything,
>> while a lookup of "foo" will succeed. I'll add some specifics in your
>> patch doing the lookups, but just wanted to highlight the issue at
>> the top-level.
> 
> So, what about adding an index sorted list of the address and BTF entry
> index as an expansion of the BTF? It allowed us to easily map the suffixed
> symbol address (we can get it from kallsyms) to BTF quickly.
> So the module will have
> 
> [BTF data][array length][BTF index array]
> 
> Index array member will be like this.
> 
> struct btf_index {
> 	u32	offset;	// offset from the start text
> 	u32	id:		// BTF type id
> };
> 
> We can do binary search the function type id from the symbol address.
> 

Yeah, I wonder if a representation that bridged between kallsyms and BTF
might be valuable? I don't _think_ it's as much of an issue for your
case though since you only need to do the BTF lookup once on fprobe
setup, right? Thanks!

Alan



> Thank you,
> 
>>
>> Thanks!
>>
>> Alan
>>
>> [1]
>> https://lore.kernel.org/bpf/1675790102-23037-1-git-send-email-alan.maguire@oracle.com/
>>
>>> Selftest test case [8/9] and document [9/9] are also updated according to
>>> those changes.
>>>
>>> This series can be applied on top of "v6.5-rc2" kernel.
>>>
>>> You can also get this series from:
>>>
>>> git://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git topic/fprobe-event-ext
>>>
>>>
>>> Thank you,
>>>
>>> ---
>>>
>>> Masami Hiramatsu (Google) (9):
>>>       tracing/probes: Fix to add NULL check for BTF APIs
>>>       bpf/btf: tracing: Move finding func-proto API and getting func-param API to BTF
>>>       bpf/btf: Add a function to search a member of a struct/union
>>>       tracing/probes: Support BTF based data structure field access
>>>       tracing/probes: Support BTF field access from $retval
>>>       tracing/probes: Add string type check with BTF
>>>       tracing/fprobe-event: Assume fprobe is a return event by $retval
>>>       selftests/ftrace: Add BTF fields access testcases
>>>       Documentation: tracing: Update fprobe event example with BTF field
>>>
>>>
>>>  Documentation/trace/fprobetrace.rst                |   50 ++
>>>  include/linux/btf.h                                |    7 
>>>  kernel/bpf/btf.c                                   |   83 ++++
>>>  kernel/trace/trace_fprobe.c                        |   58 ++-
>>>  kernel/trace/trace_probe.c                         |  402 +++++++++++++++-----
>>>  kernel/trace/trace_probe.h                         |   12 +
>>>  .../ftrace/test.d/dynevent/add_remove_btfarg.tc    |   11 +
>>>  .../ftrace/test.d/dynevent/fprobe_syntax_errors.tc |    6 
>>>  8 files changed, 503 insertions(+), 126 deletions(-)
>>>
>>> --
>>> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>>>
> 
> 


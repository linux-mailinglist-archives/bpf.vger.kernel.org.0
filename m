Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82AB92C3086
	for <lists+bpf@lfdr.de>; Tue, 24 Nov 2020 20:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbgKXTLm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 24 Nov 2020 14:11:42 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:27634 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389340AbgKXTLl (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 24 Nov 2020 14:11:41 -0500
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AOJ5T4b021108;
        Tue, 24 Nov 2020 11:11:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=lcjUr3/lTCpnDj7QvR6UssYN3xgh+IHTj1stTkw00U0=;
 b=N0eXGKvFan2feX70hnngq7z7t9+o5FgSCKDO4TIqcq/3hR8ddFOhxXF22Q5jHspCP+kz
 9e3mvPJofOUUT/sueEvqIZPNHzslAIwQduUkLWdKkKh6fUZvgio/YCkibaRxhcKLvPHQ
 SDM9Qs2mEGHjPT/bbh/2EdWUe3loRrZHswM= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 350qy4utyt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 24 Nov 2020 11:11:40 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 24 Nov 2020 11:11:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lOxnV0sQkC7b3n3l2lLViwUaGHLi8W0KJ84w3659leD/ZIHO4r8Iz3skq5QcHSph/eZ//GGW9c9VRzKLJU+yJ8fzHJIFbyKXiCnMAacI8ydZm+9uR4bz/I+AyoWY5yJlXZuvLmySZOjMJorcajY5d9uRFiUQSkIGsUubx1ZRPctj5ZOlwG1f8s9mPU05qwp6eKEVpDrBjnK39RFIpq709Nk/LvkzYPct1QJShEEs2ocNNgHePPQGhxoan9qTyswNovArDKF002UesNEuZMFbLUNT5hytcsiphAUZdCS49vTlEtO7HR2irI3GxoK1SlrkwbamSfEM2p1bj2NLyhBWOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcjUr3/lTCpnDj7QvR6UssYN3xgh+IHTj1stTkw00U0=;
 b=dIjIg76OeqyaSo97QHH218ql+iBIg0bniEOymehFVg36JpkCyyhyANDWCG0PBXvyTmjaK2bBv07Kj1gZ1UslcHa3B6ZxhRV61Q7NuoOC9A/TVuIXyZGGQ8nOSdCC9vgGF67By6Zbj/bPE+5ySMn9PdAVQirNoWTWB8cCFEIV5YSzd/dAqq6w3kKEPxkASsWBU6CSReaH9Ja2G7cDhbpLvisqFXxKE/pDQxS9fuQvDD7h76LGpFi1oVSMXVnIzmTH8QdYQtY4Q5UeyWBfMUZanV7ltr+79MN5Yv34xBRlyL9dNo0K1+PO1OKa2jYs3F4dMf9sLHXdu9kusvheYGDYlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcjUr3/lTCpnDj7QvR6UssYN3xgh+IHTj1stTkw00U0=;
 b=NsAFrdjx8eUvZgmSSTa1BK+8AZ4UqrppaVycFLylB1+WOa6GZN/W8OBh6BcvybgC5Y1jxeMi8LiPWcIkF2D32H5AiEDpWoz/M1LWWKfw5IKiL6InfW3xPJCsY2xrTfy2VIqYPVr0YnxtCPz/oTmowF7YT9oNLxYjA/tq8wsWm7U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2327.namprd15.prod.outlook.com (2603:10b6:a02:8e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Tue, 24 Nov
 2020 19:11:37 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3589.029; Tue, 24 Nov 2020
 19:11:37 +0000
Subject: Re: [PATCH bpf-next 2/2] selftest/bpf: fix rst formatting in readme
To:     Andrei Matei <andreimatei1@gmail.com>, <bpf@vger.kernel.org>
References: <20201122022205.57229-1-andreimatei1@gmail.com>
 <20201122022205.57229-2-andreimatei1@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b11e8546-a3f1-e135-72f2-3cc7995ad4bf@fb.com>
Date:   Tue, 24 Nov 2020 11:11:34 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.3
In-Reply-To: <20201122022205.57229-2-andreimatei1@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4987]
X-ClientProxiedBy: MWHPR08CA0059.namprd08.prod.outlook.com
 (2603:10b6:300:c0::33) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::10b2] (2620:10d:c090:400::5:4987) by MWHPR08CA0059.namprd08.prod.outlook.com (2603:10b6:300:c0::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Tue, 24 Nov 2020 19:11:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f4338346-ad3e-41f0-f0bf-08d890acc41f
X-MS-TrafficTypeDiagnostic: BYAPR15MB2327:
X-Microsoft-Antispam-PRVS: <BYAPR15MB232789F314A50DEDC8F35210D3FB0@BYAPR15MB2327.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 72jwc46aNA37TEwR/j6FFD3SywzXq0nrIwRulbgbLafaP3rlLjb7c4LyI4sdsiBOZma7sZlgQMHsmPj/Q/XAiGmYhjMAzzX8Au5HfvQjObmflMYZ/zMt0uPkFiMmEY+SuTIvgsje1Oer/YRhEx4TjLAvgXfQxIzXmZAdOQNi4uWVSXELGQYcy9weDF5AH9BLuQUsKFERqSqyS0n+aHvThzJaa+3gDzQ1HgW4faRlr0mO1ANVhK3z8NhrfMdM0+weBT/L17n8tjMVLCxuhU3BTsebtsCCC/PqYpbkchjGXJRTIqOTsDWVNW8OkhganEiD38oxIFWBbdrnxtYNC8rcPMfmIccw5bedqzL3wfrLWaMuA5LNLtVb/xkBbobF18vM
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(346002)(366004)(396003)(376002)(316002)(8676002)(6486002)(2906002)(2616005)(66946007)(8936002)(66476007)(36756003)(66556008)(31696002)(478600001)(86362001)(558084003)(16526019)(52116002)(186003)(53546011)(5660300002)(31686004)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V2pZYnowVGhZK2JsTHp6UHFPUFQ3L0RScjVNbDdJbXM1eXpPZ3ppb1k1WGRP?=
 =?utf-8?B?cTRMWFcxZ1VTMnlua2RzWHBKMk1VZ0ZrcThmcmZHdk54Yjd4eGVYU3lWNmpj?=
 =?utf-8?B?eUdFQTZzUkRHODVKKzNRNFhDMTV3eUQrYWhNZ3loTllvenk4bFE1aUtwdC9u?=
 =?utf-8?B?RWlYOEZxeUJHb2g2bDRwNHlsd2phMGk4dk5qRk5sWml0eTZVRElpK2YxWC82?=
 =?utf-8?B?cjVwK3RuemFsNTQxOVlRMTJuTzJiUytrengzWEM3TmRiaDFjaENFbXR6aEdj?=
 =?utf-8?B?ei80STFGNDZmSDFFeDNlNzV6TTE5WGJoTDNVdU84NVZWSDdrNWpWKzdNWkhs?=
 =?utf-8?B?Tmxva2tOTEhIeGlOWTVLU2J2eGQySjJiWk9pV0hOOEx4eHBvQnlOUmVDeXBZ?=
 =?utf-8?B?VXNvU1JwM1N4OGNDNWNtcVFsMjJSQjRucjAvYy9VdWVodXRYRHRSd1NCMG1w?=
 =?utf-8?B?YkVsRHhZbFdBRWhmcVlYMGhNWjBQRWRQVzRicnZVUkhqQmFIVEI5OE1FeHE4?=
 =?utf-8?B?YTNoQ0N5a0k2ZjNWaHd4VkxLZGRCMnloSVc3OUEvczZvSE8xNEh0SUkrUjQv?=
 =?utf-8?B?bEJ0VytWTXhSV0dld2hSaE11QmdBSjBmeHl3aGVZZnBNdFBpRWVMSG9JY0tO?=
 =?utf-8?B?MzBXRW93ZlB0QWF6R1hSU0dRM0Rsb1cxa2wzTWh5MDEyYmlBRUNBR21yZ0Qz?=
 =?utf-8?B?UmFFQmF0RUx4OTRUSDNuS1BhS1gxRnZCbHUra09vSmR1Q0RjcjRUTVZGOFNL?=
 =?utf-8?B?VmdSUTJDN0RaaWJjS2lwVWZYamthVGR2aEhSRHFzcFBZejUyZTBBZ3czNS9Y?=
 =?utf-8?B?ZEJRM1MySUtpRGN4Wlg2TjFOWnF3YitWZDVoR2J6N3ZYbmRvd01PbzJOcG1J?=
 =?utf-8?B?WmlUazgxMFlsTjJkNUpDZkVPdnMwcWtpaFB3S3hySThvVElObXIyNGZzQjVW?=
 =?utf-8?B?N0YyTDMvSG16eDRhcFBmeC9zRUNEcEUzS25jN1F0aFQyamNlR0VVc1RDdzNr?=
 =?utf-8?B?U05JM0krU0FjYUhiM09sSmpHeEJSUzJIZk1ncFVJMnhsMk1tZEdSQTRudFRk?=
 =?utf-8?B?SWYyK1RIZjdWYU9wYVJBbjNkMm5CbmExOGlXRHFiWVQzTEdIeGQyNEV1S2lQ?=
 =?utf-8?B?WjBWL1RBMTRickhBWjl2aTNhcHFlYU1tYVYyMHlyOTlWTERIdVdIZFhoWUFM?=
 =?utf-8?B?SDlycjgyODJVN1ZySVhnQW9hRy84QlowOUFOdklTbC9QQnJIa3laUW8zTmxW?=
 =?utf-8?B?TDVQMHhqb2NaTHR3KzlKOHE4bTlya2h0N0hOak5zbHd3czBJdWFGWGdnY3VI?=
 =?utf-8?B?ejhKQVJlMk93b1l2V21RallPR1hBRERHZEJ5eE1rdHlYUmhBS0dud29xQ0g4?=
 =?utf-8?B?ZEE5eW1DT0M3NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f4338346-ad3e-41f0-f0bf-08d890acc41f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2020 19:11:37.3536
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mw+RnmnfrGCaE2JWWWc2SdoBIQh2dBFZN793u0OpPE8HHBxubpSJkY0u9F5F2qdo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2327
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-24_06:2020-11-24,2020-11-24 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 priorityscore=1501
 adultscore=0 phishscore=0 bulkscore=0 impostorscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=943
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011240113
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/21/20 6:22 PM, Andrei Matei wrote:
> A couple of places in the readme had invalid rst formatting causing the
> rendering to be off. This patch fixes them with minimal edits.
> 
> Signed-off-by: Andrei Matei <andreimatei1@gmail.com>

Acked-by: Yonghong Song <yhs@fb.com>

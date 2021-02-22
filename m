Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD59A320FE3
	for <lists+bpf@lfdr.de>; Mon, 22 Feb 2021 04:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhBVDzq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 21 Feb 2021 22:55:46 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:59128 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229889AbhBVDzq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 21 Feb 2021 22:55:46 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 11M3pnRb001640;
        Sun, 21 Feb 2021 19:53:58 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=hgCZVxmkdrvgcaxDgmqZQb032Vv/wuuHgt5yBXxkotM=;
 b=PFMrlLlWgUVltji1hoy4wWqIGdjbbtntOcnko5uVXrm70ld9lwf9g5KrFqYkScN3+utS
 ApLk7M5cYqdcu1HDo2Z5+I1mlPFQHNCACPzwsBvWgOczLR4mNRKmciqFa8M73dJUgEIq
 g1bW8D4KE8DFr55rtG4jfmSLVKgNUxD1YoQ= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 36ukhy2vay-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 21 Feb 2021 19:53:57 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 21 Feb 2021 19:53:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MlLMV0DXFleKBh1t5e6yUC/XYGMCqwvgnEfhsGt2S5GxffXIBuwvvL/YSh88/oRumSuIMIE/pSI+/2aJeC1XP3wrbtgrYIow7ytX46NbWf+Xd0XrNDB804YyHh6+naBBzMiK0VDKBo8YE/2cyJtE2jgAHSRCd+mDAQVy3DgaWp3Y95UXJ5HiO2E5dOSBDdhHkYim5OnmAl+qMn0SE3FgAWa9b/G/ttt5BYGJCD1rUpKFMn9LIz4kQBTBQYGadWWXlh6M0nvo+UKHSajNWdf1gntswRtaBY3Nu8szp6Qtn/EEro0APUk2jhw0+FkWqJOtWhYQYGc2sBRnwDhMROVVuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgCZVxmkdrvgcaxDgmqZQb032Vv/wuuHgt5yBXxkotM=;
 b=MC0QwzNffWcxRRBkUul34NRDHjQdbvzfKVoVgQ/Ws+L3WTn++Y6lZQ+lebo69mNIsvOtAyucub71H6tsOP3jlqtkWD8T6WMIyZVfH6ovImsLIEmkZ9f3WuQ0wcY3opUkJIMXvm0wwEgZ69U2zcBLkJoRjB4QuUfUC1KZgrp/0Yz6vtMDVyrgECxdcCL4EnJ1vAEO7Q21dUOVwqErR4IrL5TrAGuTxBszUcwKlgLAz5VgfM+Ccf6db4otPfmmdTY+ZxntkI4K6V0n8Ss8vzo0JSzN81j2fVrGNTrUE3q5wuu92JeCSxNodfW3iAihq8zzvQbjIee0YU/93h4V5asgrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: linux.ibm.com; dkim=none (message not signed)
 header.d=none;linux.ibm.com; dmarc=none action=none header.from=fb.com;
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com (2603:10b6:4:a1::13)
 by DM5PR15MB1577.namprd15.prod.outlook.com (2603:10b6:3:ca::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Mon, 22 Feb
 2021 03:53:50 +0000
Received: from DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3]) by DM5PR1501MB2055.namprd15.prod.outlook.com
 ([fe80::4877:32f3:c845:d6d3%3]) with mapi id 15.20.3846.042; Mon, 22 Feb 2021
 03:53:49 +0000
Subject: Re: [PATCH v3 bpf-next 5/6] selftest/bpf: Add BTF_KIND_FLOAT tests
To:     Ilya Leoshkevich <iii@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        John Fastabend <john.fastabend@gmail.com>
CC:     <bpf@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
References: <20210220034959.27006-1-iii@linux.ibm.com>
 <20210220034959.27006-6-iii@linux.ibm.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <983f126b-06f9-1684-6894-2e637eaae8a9@fb.com>
Date:   Sun, 21 Feb 2021 19:53:46 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <20210220034959.27006-6-iii@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:4afa]
X-ClientProxiedBy: CO2PR18CA0062.namprd18.prod.outlook.com
 (2603:10b6:104:2::30) To DM5PR1501MB2055.namprd15.prod.outlook.com
 (2603:10b6:4:a1::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10b9] (2620:10d:c090:400::5:4afa) by CO2PR18CA0062.namprd18.prod.outlook.com (2603:10b6:104:2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Mon, 22 Feb 2021 03:53:48 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f778886-5d6b-4ba7-1848-08d8d6e5767f
X-MS-TrafficTypeDiagnostic: DM5PR15MB1577:
X-Microsoft-Antispam-PRVS: <DM5PR15MB1577DA8A70CA620A87D458CED3819@DM5PR15MB1577.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5jvMV2GC1A5ts4zYIwHrkHNcShqqTBGf3HO+nvTqXYmpFxJ7L2NDJJUgd6CGfoeEc0yTaKw7EW0eqg3uZzGnxCAMjj8UTApFYWOu3sI5zoRyuUfLybEDR2xXS1RMmHWcJRvsshSpF6iM20HgjJ1ROH+aPV7/V574lsuhAIyMVooIqXuXo9n1XD1GALyQEuWHrcbxwWoZMrm4sa3LrJhnj9y8DmmfUkDClrykeGJRNz0Bz5ur1x2Ob7qPTP40vpfx7AQ9DU9Be5Xbw6Tfg1+Zz7C0xcjTwmbZGD/v5mx+xOurVkfL2uWOR5AR5iG7HrQaW3QjhZ2TfgkMpz8FO6Jmc03T84WOIBqp8l7no8OBfTDSoK5sFn8qg65QihCz+t2jrSJAXNzKtGng69uwO/C9YmtSb5SdRMsBYoY9pQVfRD7NC9ChD0skju7e1StmGfluoi05Q+2oGbu02EW9YppsvzFG6MQ/H4UyMXH6SeIisvRqUbBwhgHdiHFjm+5vGzUp4oCxevNl8BcD1Sumbq78kKS6rnDJyknPsZbnmzROprbFtqYG+Ey0APzLjz1OU7aAPOr1fhQ4h/u/hjwk4kGE5f6s0quz4srvhIAUUnD/20=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR1501MB2055.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(376002)(136003)(2906002)(86362001)(31696002)(66556008)(66946007)(66476007)(36756003)(110136005)(316002)(5660300002)(558084003)(478600001)(54906003)(52116002)(8936002)(16526019)(186003)(4326008)(2616005)(6486002)(53546011)(31686004)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Wm1HeE1tSzNDYXkwQ0JIVnRzNFJ3K1VyS3lncDkzcVFiczl5QVVzZkcvaDhl?=
 =?utf-8?B?NFdiSlFtdGNDL3FoWVM5VVdUYkpFcC9HUGNQNWROeXJqVHVvdzdXejN4WGt5?=
 =?utf-8?B?enRzNVVFUGFXakZUSUxILzhVcW12V1lqcW4vQjhNRmQ3am9YRkYrTEhRR1V4?=
 =?utf-8?B?UFpmS21IN2lVNDJKRjgvMHl1NHhqK2JJSkFRS0tpa2M5SXNtcnh2MGkzNGRW?=
 =?utf-8?B?NFkvWXZhZnd1MnpFWmZuZVRqWFpJY20zM2xBOHFYOWJZdjNRQVpoZjZyYTlN?=
 =?utf-8?B?SnI0dFhIM0tSdzZ1anliR2V0Y0dkc1RhT2gxN2lWOVVBaFZ6dWdIZUtOdjJN?=
 =?utf-8?B?NnQzQWdBQmdIeWxybWh4WVROR2pMSlh0UVJJOGlZS09FQzZTa0Z5Qis5VU9R?=
 =?utf-8?B?c0pHY045RmZDbE9Oekc2YWxpeituWVgwZGVoaE9WTytDOEd0N0Z3V2JvUjBG?=
 =?utf-8?B?d21lWDlnMHZxNi9ZelB5ZmJCNTJWWlg5NGNGQjBVUkVvUjhXaU9DTGJaSVZa?=
 =?utf-8?B?YWpJNVkxWjVHeU9UclkvMzl3MngweS94dWVlUVB2V3BtOWo3VElycTByYTB5?=
 =?utf-8?B?aUlNQWlZRnY0Vys3enZUbkFIUmJJQ2FQQkZoM0JWdFRPVXV6VmNwUzgvNDk3?=
 =?utf-8?B?cHVPR2N6aEhXNXBnVDlvbFZZODRzVDI5T0xTVXBEQ0JDZkJVWDJJdmpHTjg4?=
 =?utf-8?B?cjk0SXl2bEF1eXN4WWpsWVd3eS80WVAvSmJ3amJPek1ZL3QrTmVreTFDcVBv?=
 =?utf-8?B?L2hnUVpveVIrQnora05mV3N5b25kdUVCdzYwMFVtVGNGdTZ2Zmp4TjRwbDBZ?=
 =?utf-8?B?eEJTTFFlMTE3UWkyQ3d6T29WOS9NbExnQlpkRXZWeWtOUFZ0cjV1WXkyMDFV?=
 =?utf-8?B?RCs4bXVSY20zMHVmTjNIU1ZQNWYrcW1aV3Z3UVkwM0g2YUw1TUJaU0txTGdV?=
 =?utf-8?B?UHFkTS9qNDlYaS9mYkJBMlRJRWJKM2JMWFMrUUZWQXBjZTU4OGFEa1dWeEZk?=
 =?utf-8?B?SzR6VlF2TkM5azQxWEQvQzl0NU1rdlFUV1dpN3l3N1FjZ05xMnB3UUs0TC83?=
 =?utf-8?B?UldXUERlYzYxTWdDRVlWWWI2TzBiMjN6UWJ6Y1JYc3l2cEoxRFc2eDZWMGtz?=
 =?utf-8?B?N0sxd2ZBRmk1bEozNDBNZGdCdDVjVERNc3VaaEFKUnloNFlBdXRnUkdLRlZi?=
 =?utf-8?B?K004K3IxTmIxaGJpamQvOEhCWHJoaFB6TTNDalRGU0J5T1hkZGRLWTR4SG14?=
 =?utf-8?B?N0w2UG1qNXZ0UTZiTGx4Y1h4UmF3ZWNxem5sNUNpdkgvSWhCUnozMXpJQms4?=
 =?utf-8?B?T0tGa2t2TTdzS2ZDeE5VMUFyRE80ZlpOaE5OdGlhdFZkdGJ5R1VRTjJRQ0ht?=
 =?utf-8?B?UmVUVWtJZlkrVW5oVVppREtTSTc0TlVONFZWeDExMVBoSHZCcUNHUFduMGpl?=
 =?utf-8?B?U3NianhTb0xYTHhLU2xtVWw0RFAwNW9oMmdLdXY3OUVQQkhPMkxqUjhiR1F1?=
 =?utf-8?B?K1lHNzNqbHdIazBuckVUYk5lOWt3enhKQVlvVDZDWWl0NU1MSjlaTTVHTnVM?=
 =?utf-8?B?L2N0aXdjS2xoOXZudHNya0ljdnU3UWdoNVJmdWtKUHFtSkRjeWg3SFUrdlR5?=
 =?utf-8?B?dU8yTHNqck5rc0ZoU21VM0phNDVPRlBGdnpNV0krNEJmUkdCL1JmanU3MGgw?=
 =?utf-8?B?YkVaR1V6ZHFGMlMzdFRtU3Ruak1VUllNVlZ5bnZmOHYra1hLM08rbC9iL1Bi?=
 =?utf-8?B?L2FEY08rbm1yNVloU2d6RitpSy80NCtXdGxoV3owMHBpTStpUXYrU2tRMlB0?=
 =?utf-8?Q?Tu2PIEl9SJuBO67/yOnsWjc5uubiPlagh5X6w=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f778886-5d6b-4ba7-1848-08d8d6e5767f
X-MS-Exchange-CrossTenant-AuthSource: DM5PR1501MB2055.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2021 03:53:49.7660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xr6itJY/uONEJfbiWZiGzC3bbn7fmYSJs52plKNW5tZdN894DRdutKPe6yLK97O+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR15MB1577
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_14:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220031
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/19/21 7:49 PM, Ilya Leoshkevich wrote:
> Test the good variants as well as the potential malformed ones.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks for the detailed tests!
Acked-by: Yonghong Song <yhs@fb.com>

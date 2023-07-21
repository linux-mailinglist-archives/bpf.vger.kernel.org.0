Return-Path: <bpf+bounces-5623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F1375CAC7
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 16:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D2C91C2171A
	for <lists+bpf@lfdr.de>; Fri, 21 Jul 2023 14:56:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C20B27F28;
	Fri, 21 Jul 2023 14:56:49 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFEB27F09
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 14:56:49 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE8B30E8
	for <bpf@vger.kernel.org>; Fri, 21 Jul 2023 07:56:43 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEGEHn003861;
	Fri, 21 Jul 2023 14:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=RAp+xUE9zWgT6nIejn+D4g2i9tlweL+ovXT4UHUSde8=;
 b=FAW5TAy1IEs4VgjM/iqd1nUTuE2emdL4MseE5KIB6x/bGiTUhweKHyoaeW6wrTe5Ccr9
 gXP3zPjUmtxqE5iKjI6c125cx/PFDH5SoRfJsuhs1Gqk8TuvEqg1EhfExLc2KEHeNTIm
 mE41RZyo9HgTf6E4iZoKN6N/PG6JJxBlx5u/PvZOTSgj9W1aIq+AhmTwKrd2LnDhpe92
 0rxQf39eQk0YYdeAPSeTk9gbMNqlqQ6hrP/V2cK7Dv7mkyxpMtgW29xHpZwBpP49jqI4
 jOgiSzTkwN6vfTFMj+g2LFn8DwM9dBKMj72FSdJuvi4XpQIHlvo0Q1Fk7Pvc3++IS7nE aQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3run8a45t3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jul 2023 14:56:17 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36LEhLas000917;
	Fri, 21 Jul 2023 14:56:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ruhwa49vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Jul 2023 14:56:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRCPy1KK7TgJddKYDDkIGMQSp48BB8CV3gLlEz15YPUnYkLQWIsKT30S7dpRVU4VhLi4uHyQyGofOvYx/0u4sqbtdVHXkVQOdG+DURHDkM90sWv/2IflXyqGPA1yJtmgR1PtJRK9MjOSWZKRQx6tSiiWbGKo0MbgcG6EfgDU12yZ6fkqguSmGzzeSn+aEufWmP3fm1yiZ5EomGsosIO3CtCcrKUOJSWEXKMfCOwYHO8mnG9VXb/w05oW9/Vi70mUXXEr7VkRD/6RbkbP/qfDdPxkcWPkpoetEEZ++we9vLtnQ4PdZIYfKkqh587alqf++umyygLsNlR3XFuZmTs/gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAp+xUE9zWgT6nIejn+D4g2i9tlweL+ovXT4UHUSde8=;
 b=W/msGf7xA4esD72FP7fdRtv8NajeJJ9ZuJXlKUvoH/QuQry/VRQUpct1dq1sl1ddV6/E8J1Kj3di2G9JRdim7w/LZVUWRorbFAkVN9X0g1LRkLWIv/8yMbJi///mwXldGFH061AwpZF+Wv2TDd5A0Ax6nkDTj39xzrw7gpXbIcYg3TkjRcE2wyc6641vIL/0VR92mnUHVGeEAcAZ7raE4htDuT2Md+myBzdvesowUB/EdF8A/TVLGfx5DTmJjMgF+ur+MQTF71bxa9HNBO+6nvaejdP7v7Vi5VHTahcIR3y1g34cEw74XGsl5hvhn+F6u7/FysgD+jMsK0D8ZiVJsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAp+xUE9zWgT6nIejn+D4g2i9tlweL+ovXT4UHUSde8=;
 b=bdFeQ/VKyumvpkYv+KqNSMBHYeRK9D3FE03Qefxc9MhAPMcR/0CqOKm0eK0DYFzti5t9BOf0NblcieqOHYdqck0JZeeOd0ANWFlQkyCxXoFAjNo4is+o3iSDsBChX/6TvYVMDlmzfprevhtAnHu+MZ9woe3TvNk483GaUKjGIWU=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH2PR10MB4230.namprd10.prod.outlook.com (2603:10b6:610:a5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Fri, 21 Jul
 2023 14:56:14 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::4d0c:9857:9b42:2f6c%4]) with mapi id 15.20.6609.026; Fri, 21 Jul 2023
 14:56:14 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yhs@meta.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii
 Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Fangrui Song <maskray@google.com>, kernel-team@fb.com,
        cupertino.miranda@oracle.com, david.faust@oracle.com
Subject: Re: [PATCH bpf-next v2 00/15] bpf: Support new insns from cpu v4
In-Reply-To: <aa910249-cc7f-680f-144a-b6f6962b277d@meta.com> (Yonghong Song's
	message of "Mon, 17 Jul 2023 14:52:32 -0700")
References: <20230713060718.388258-1-yhs@fb.com>
	<8b3e804bc23d44ba3a30b9d69e6590bede857ed3.camel@gmail.com>
	<aa910249-cc7f-680f-144a-b6f6962b277d@meta.com>
Date: Fri, 21 Jul 2023 16:56:03 +0200
Message-ID: <87351h8gak.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0152.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c7::15) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH2PR10MB4230:EE_
X-MS-Office365-Filtering-Correlation-Id: a16f40d0-6e0c-4e3b-8530-08db89faa0f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	cLcPLz72mAOjwmvzfkU2mWmAgYiqX47KQ5Y89GqqmQSQaRiwITDlVRGoJFmYqA83OpFA2Iy0AyusocTPAejovpNsNWypVt2kBVzM4Rt6Su4F6/BBU3TOz2bZQecWObV+pE4eE5QcJRqUwG0Yz4voNpxS6SKMF6/OML3d3KWCqcVeLAySKJSBEoUi4ftaw+VjEuvb3wQ+JwihbVSg8Zf4a6dicVQGHf3fvdJG5O6CqjfTBSj1AXBROSQLz2qUXdZaWeSgA5ar+N2pKImUsankQRBVniNu/SKdBz6vz+JA6BQk6GsDS+coB1Jhq3o5EzZ6GQuqki/M5/vFQp0ug+2NPbUE56OZmlhCH+V5u5s67ydIZ7pKLrzHBtkq0xhV9GPADo8kbj8JHFT2oE3rB0QGAQqLc3kRTw3H4Hg3hRYFdYnWDs9iotBfQgY4s6tGlW+m4CMJQenoMbVEr2ADneq2qtpkqa9N9Eo+HStLDDdhP7OB9brlWzZokH8hGs2MUTn1L9BfwjeDdMQ1r0D7jFFgpqWAW1bwShEVxnf9vptyus5CY/MOfvkSDkYN6YzI15Cx
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(376002)(396003)(346002)(39860400002)(366004)(451199021)(66476007)(26005)(186003)(6512007)(6666004)(4326008)(6916009)(66946007)(316002)(66556008)(6486002)(41300700001)(6506007)(107886003)(5660300002)(54906003)(8936002)(8676002)(478600001)(2616005)(4744005)(2906002)(38100700002)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?vauWvkoweInEUhquuhQFFTKADjJkCQUomjm2/IjjbNEhnzaaJwp2v7xEl89R?=
 =?us-ascii?Q?KsEUAVFAPnlH3RPwTL1l6Gn5xsqe4t/0/8iovQodmMw5ByzjaC4Cbb8JyfaZ?=
 =?us-ascii?Q?mAo6nBT1LU4MhXA6woJRVSLlOepHJQg+TX2+1JfdWDL0ntqo2P3Du2L6xTXR?=
 =?us-ascii?Q?+nBAQhewayqTbGWDMDbUWCAaR0htLjE6xH/y11xy26OgBszar+bavwOuDpES?=
 =?us-ascii?Q?2winYCHd6d3e7hybJXijbkAlcGhxmEMKpfzSZzMEocdQHXLLFYtGux2HYT+K?=
 =?us-ascii?Q?zQYIvjlWR+5gLtUlUDiZ3RUmR5UGHeqJN6fMSJ58dLmpT4M5NFjGBrdGH0us?=
 =?us-ascii?Q?SUARrtI632PgWlJQmYcWbuINzA0elc/0lGNpO9AtpkJQlGSeV4vhK/OPAi3D?=
 =?us-ascii?Q?6hUkLjY/CM6yfNW0raZopeEgwxR/hcLu1nadsXqYlBrnT+eWHE2fPocGhQvX?=
 =?us-ascii?Q?bMrnLtUX7dlPaCoKbs3A3/3R2oLyFPSUS8DVBfC9kvB70ME9QCCVraBp5MJE?=
 =?us-ascii?Q?A658RNkIiH95E63zmA5kGElK0KkoCD4rYqf7NJedwGbQC5Pxz2736Tt21Bdj?=
 =?us-ascii?Q?y5FzP1UqJVyssXXTY8ZEw6wIW6yBvgYhkT5zeR5y3c4A5A1tYu1EqXLgLRrl?=
 =?us-ascii?Q?8nvqRFC//TauBm5lA56z3sMPYGohhJu1HMH6vHGbZWHZ8yaUN06vyZNGWt9s?=
 =?us-ascii?Q?Uy576OZv8xaiGPJavyFvR2X5UOvKajAzF6ZfIVBYKp9MSKPVRd78jTygvanz?=
 =?us-ascii?Q?3dMe5lYo5zD3/9yaYw7C76SMUTNK1PQZGF0rOjzzAkI5cqULZp34YyVDoSSI?=
 =?us-ascii?Q?JhaSWIduKkncsODNpbG47zpC8Y0MZImT+N/soPNvOFd4bVeGFmQ4bLQt3hEL?=
 =?us-ascii?Q?8KH4GUgTbwu8vTmmHZtrCIHk/9E6J+atZc0w/qIUN63YPKBFwmhCM2GyoiJp?=
 =?us-ascii?Q?kOJtmZtmeLP9F3hMcQWYifXIG8P8Wv7Kq6dZJ/JbrLy179lR83kiElyy47g+?=
 =?us-ascii?Q?V2FVDOtLI41PNk6ET/Jm6zwjvemUg+OEFtKeGPASmQwe3Q8ZIUQpJr1uiCHw?=
 =?us-ascii?Q?QWMtmcaA1JVE65gkQg6D1rO0W4378xk4SX3oZlg1r6SqecK7UkkO1+iEl7bM?=
 =?us-ascii?Q?ST0wTPnswYM+S7t5iK4b0NkPuCHvkB2jOi3Y0+9fkRsTeDpq9YDLrOT8EkiM?=
 =?us-ascii?Q?sF2Jl28dXWdD0Ac+biZ4x8jYVSO4o7u0Mg7CWJDQF0BC5EYRHMp2ZYS35aKr?=
 =?us-ascii?Q?p5wzAckV3qxxcecr2S8qv4mXQNUpYHbFkd0BWMH1p/U1Ep7OhnFD7RL/ZYI3?=
 =?us-ascii?Q?+qRgh+WODfIbJtkXk82OZ9M34pQcHg8TmvSVEk1rA/G90ziJSeuYgKQFj7nf?=
 =?us-ascii?Q?T5oxy/QMjRMjwqN7AugxmD3n+KTUZkXrH/arI95du04tB8i7I7JqPhCkNpBx?=
 =?us-ascii?Q?HgcZz2NYLk4xqssXYyqtUITL7NMjp8Zu7RwkDrUw4RpK3pjUlm3dKbnRbE/4?=
 =?us-ascii?Q?W1yqK6ZtJRUDApUajzvFrtKLxiveXs0XXBlvN+rlmS3ZYGu/8WNXS566cN31?=
 =?us-ascii?Q?rTauCwnCNyWC/oSIPb9TgsNGQvKf6kpHlLIgXQhKG6ZG+tsdirj9P9NjHyLb?=
 =?us-ascii?Q?FA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ZK3dFcpYwfpGSWXuwwQANy7Qj+SIwPVraFJS8+oC4/Pd3KIFIEmm2NnDkk/WytYincczeX+KOwtPG4Gm+fPXHIbYGzwT1LT2q+OowB1NUD2lgADpZOoCzIhrOtlicZkhXDw30ojopKGBqJgrAvteiOHZ2ltmdj2BMoYOm+8OgHH6LuSYG3XT8+npwiC8lUeu+XUxxQyZvrjXYKuiFrJ14Ep9GtMhg+7po8ZwUP18d83Qfgmp00Ta9q5Twa1239pUP4syijrxzmGgn53oGpa/pDAcssy5XR12xrKZG1IkmKjaNemJru8HVVBmrkoD9Mj+L/bnL2mvBaZ/5o0d2Tpfbd9Jgd0bJ2be/CKiuUObQY2G4v6fo0HtjhXI12EpX7qxVgez9BPWT931ujgz7GM2KLJ8wLFU6P49GLTnBirEHkj/M7CPwgDBdHFyNeOLFJZV5ZAFgfbMXNeUSkbzxmbynyaUrAcysrKN47eYTqKXA2TAo6Z/ANkGiWoeAVZm5Qy7y0WPyumetjwt6NU1uKLLbsupoymx5QL0wiagLAwIXepFBNFfXPYTKS35CC0Cjc8jcIMmw8WuBp2noMb+CigG8I+bzYSSapHwK0tJ52xNngy8ZBS7xqXVAYyIw1g3pmedOjMNBVCrkG4OnzeWLIu34+E6IMkRJpRshSBhIEgc/OT6XXnzB8H2ZJgHXvywKVMzbzEeg6smLclBvOZjmjrmePOdJsqDwgUNAMIVZGolceyliB9f5ngoB9pJ1cE/wD/oomq33t8z/RYa8W/C4l0PkRHlSa2keNNuKxSBXHrzOhY5QbrI6CxlXk97eiV6w/xn6gQ/jvuDIwTBIsTVUFHToI/+AuKUSt7//FNy3WsqJJ7m2j+dD0WyIhRT6ZgDQTy9gfC5wwkr35bHQC2w45lHZ4FAJ9L2SA2QIjYxC5dedfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a16f40d0-6e0c-4e3b-8530-08db89faa0f2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2023 14:56:13.9567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +yIqTQ+RZUR8FCtI12QMWzaCvF8LSMk9ax5FhKsjIhS3sZUfojLdJ0cBvcaFk1IDy3ShmKuIl/Ta92aJLzOapFopHSfOgRGY7WtwNYIdF50=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_10,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=467
 suspectscore=0 phishscore=0 bulkscore=0 mlxscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307210134
X-Proofpoint-ORIG-GUID: OJijtKzh2NcYhEdbtTNIXn9_q6dQTw6v
X-Proofpoint-GUID: OJijtKzh2NcYhEdbtTNIXn9_q6dQTw6v
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hi Yonghong.

>>>>    . sign extended load
>>>>    . sign extended mov
>>>>    . bswap
>>>>    . signed div/mod
>>>>    . ja with 32-bit offset

I am adding the V4 BPF instructions to binutils.  Where is the precise
"pseudo-c" syntax used by the new instructions documented?

For ALU sdiv/smod we are using:

   rd s/= rs
   rd s%= rs

For ALU32 sdiv/smod we are using:

   wd s/= ws
   wd s%= ws

For ALU movs instruction I just made up:

   rd s= (i8) rs
   rd s= (i16) rs
   rd s= (i32) rs

For ALU32 movs I just made up:

   wd s= (i8) ws
   wd s= (i16) ws
   wd s= (i32) ws

Thanks!



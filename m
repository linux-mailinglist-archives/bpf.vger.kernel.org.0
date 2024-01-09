Return-Path: <bpf+bounces-19254-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E9E82846C
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 12:00:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BF4F1C23F8B
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 11:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B4436AE5;
	Tue,  9 Jan 2024 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="X+zbZUgd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cBDi0Mvu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A19EF364DF
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 11:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409AxniQ012656;
	Tue, 9 Jan 2024 11:00:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xFwsrZjKyjbSdvqeJljo8pY4v9X8BC/HtvXNGwBvUg0=;
 b=X+zbZUgdiQM+9fzButIIie9H3wljc41sVPWqi8sP4xFTaINRatM7LPdh+DQwxD3F9xUj
 Vkg8jMedc2hHpBEd+L04bn+ZHjaBlvDpDp9fTpR3X+49PMlaqggeTwjoF1bVJXNcM1RH
 pIrX7KRbuWrEavWhU5TgDqgDLUOZf706cs/oW8Kj3i268P1DIi6uRwb+2obdFehdPnAG
 o6u8aAUbcllQ3U3KIM0sNyeRwuB+223etSjYHhodxTI7JzB/BRXC004ntQT8wy4OLiE5
 SdrqyLcF3xNLwE/n6M1oAEy2Hek5HGeoKMZkOkv8JY6pZphuNm7N/EHX1S3M7lS590n8 pQ== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh4vfr00j-5
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 11:00:02 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409Aa64u006647;
	Tue, 9 Jan 2024 10:49:33 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3vfur3jk4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 10:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHWvKtQxDaLC7/fhwsg9ZZPNrLgz62/tEFOEnqAe49HShi+9sgD90+TNJPGggH7SKggyXmmkJZxJAsA8pZGgaHCw0lJYRyLxryuV9Xu6JUP7YA900gN4SCdybXy6bLeCQs//hxgm0CGmNDDSW1Ald/x/1ozj+YOgsj23fC5hrAuuIlfsjNQ7gT3Ei6x+QFNEdaL7pLgWknXX4ZGFkcKoeVZd1V1gEeJ4f2d7pgnBf/58zpPpozz5daxWiSryCHcZsLdXwos/9C7u+uvy2oM4IHacmBUPSTcOr6TsaDvRYYLyN2o1JVRn1AX0fplQ391A1iSw+2aQVdb4F8xFYUFSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xFwsrZjKyjbSdvqeJljo8pY4v9X8BC/HtvXNGwBvUg0=;
 b=DXyGWzfsOsYGWIIoV5rRX74QDQJmBvzV9cvlyZWVe8jhiHU4PMggHd1atsDoAQire5qnQ6BZO9D4HxMCVvNR6bpgZ5FBYx00WPomeNmFQlCM+uVQk/qZv7fQbkqWzgyDk9qwBdZ5kHMdWO8glsTYvSPov12/DAcbL96AP9e+zsIGLRKHOEboXkYyzPZvHBdSYmOC28hSXmv8X5lCk2ViAqXIqdoHyxy7QwJD5Tmuyp5lBfV27EXy5/Sylo5cV5QpYVWQu1FYwT4pjyxeGUds2r6x++Pxk0za3VExR6uirLxLdLtBiOEZQAj9x021+y93QFXCzGClKBWj7fZpzuSNDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xFwsrZjKyjbSdvqeJljo8pY4v9X8BC/HtvXNGwBvUg0=;
 b=cBDi0Mvudz/kFjRCzS2o/79GjQUsDxzJcYBl54+iK/+yhCgvxllahtVzJGsMWpDkPAC0Bg4PEAcOc+kyUX0Y/6POOghcc8k4/4ulixGJ8YEs2DIpODa+sPnp6e/DNWfX5XxYj/LeOFcY7kp/0P2Ynk3MHUBgiYmpzQeshUYNkaQ=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by BLAPR10MB5300.namprd10.prod.outlook.com (2603:10b6:208:334::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 9 Jan
 2024 10:49:30 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 10:49:30 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
        "Jose E. Marchesi"
 <jemarch@gnu.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong
 Song <yonghong.song@linux.dev>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau
 <martin.lau@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>,
        John Fastabend
 <john.fastabend@gmail.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team
 <kernel-team@fb.com>
Subject: Re: asm register constraint. Was: [PATCH v2 bpf-next 2/5] bpf:
 Introduce "volatile compare" macro
In-Reply-To: <CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
	(Alexei Starovoitov's message of "Mon, 8 Jan 2024 13:33:57 -0800")
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	<20231221033854.38397-3-alexei.starovoitov@gmail.com>
	<CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	<CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	<CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	<44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	<CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
Date: Tue, 09 Jan 2024 11:49:25 +0100
Message-ID: <87h6jm6atm.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0316.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::15) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|BLAPR10MB5300:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd000b4-1a15-4b21-68b9-08dc1100a7fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bngiVr7SV99QojRJKNXFh5GHfstsggXWBOGOeuTDhD/IcEEWTN2GkT6Lx+Dv+RyJbzsdpNeT509Cs31ELBs9VpKq+4YvAlgxoX9WxmBQVMb73rSvQNHjUiOa8jILOyQvUS+ASldLxRYBtx0jW8S6cQ6rDtcBUdtNnh878dJ4uqg06OrUSNMPgwvftXPDn5H4GeWlqVs21yBlJhPdrk3ZKdEbxVx8pJdiIu7bil1Z/1L5MuQjnDSCCOXavtUWIaU0hfyx4NjJPGE1kkLm9DiUKe2xaHV4yW2uJl9+QfLbkjbMusEpYWLn67gNpldV6es5Z73vvsmRUglBkAb0qY6vPsCU/J3vFRaKgRIQp87IB2HV/EMW1vTTwVivOuWFpzcDnDu8eElG5tzFuGj91u6NtYglOpZ3lGTV9ikhXA+EtB+uSHkNeTIsI/Q5wJkGyyHJmF+JcmYVFh2Nm0+c0tuH0VmKSX/aRD8c5KNyxCqpnZ+ImRctfRI0F+XGuKJTKUUtJoF3CUrguPkEhNV9arT04Ne9FWwNdGL7vsT96vDNNYvHQxH8WiKxtk3ZbIwTjGoyr4ma2SI/GBe+G2PY4bZuRWA8xjOIJQSzBDkOFCdKMM9Ogbx7mSeJHxh8VOzHWCF+
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(346002)(376002)(39860400002)(366004)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(4001150100001)(2906002)(30864003)(478600001)(966005)(6666004)(5660300002)(7416002)(4326008)(41300700001)(8936002)(66946007)(66476007)(66556008)(6916009)(36756003)(54906003)(316002)(6486002)(2616005)(6512007)(8676002)(6506007)(53546011)(86362001)(26005)(83380400001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?UXM3QWJkQi9tSWRqcnlCeXBEMnl2R1pBR1Jwa0VsaHlDcXo2WTEzTjVVYmJx?=
 =?utf-8?B?RjFud1NZL2xNMy95eExCa2RKeUZET2QxMldkVmZHNGk5c2ppMWZyeHFyQlNn?=
 =?utf-8?B?aWRJUTYwWDZISDJaWVRQY3R0bWNlVG5KZjYzZ1RGZ010VDNNTHZ1QW5NRVVn?=
 =?utf-8?B?QU5vSE5PVC9CRnhVeG9LSVE3TjhLREFLT2huWmR6SkM4dWFUMGV5WXFqMnYz?=
 =?utf-8?B?c0dRWmk5L2JVczJ3R0R0TG14M3Y1K0N1K1NNM1VUdG54bWxuaWZkQXVvTi81?=
 =?utf-8?B?QkVxUTByTUtzcUpqSUZGNU1KU2lYMmtBNGtJR2NoWjFFMW1TYkxzcXNxZnVQ?=
 =?utf-8?B?TVlyK2RQRjNJWWFBRTZka2Nvek0vaEJXWkFqckJFWnE4RGhFNUhqeGt0OUE2?=
 =?utf-8?B?ZEtHRXJpS014cWpmWjZJd3VXenJLQjdmK1BIZ0gvNW5FYzhaQS9nQzhoODN2?=
 =?utf-8?B?Wm5obGZUN1AxL1YwbHJBeWtBcHF1aVZPd3paN3NpZXhxZXpnRlM4VHgzSHNN?=
 =?utf-8?B?ZjkvSlE0bG5VNEN3ajV1dTM1SDJ6OTlySDVNcTd1MFp2a0JFcmNMWDlBckxV?=
 =?utf-8?B?Wm5TbDR6UWE3WW1XV1p6dS9QdGh4OTRqMno4ZW8zVFJWTUhzVTJlN3Z3dXJF?=
 =?utf-8?B?bE8zb3NWd0xYWTkySjZQL3FoZytNbW9hRUVnOVQ4SHhhcng2VW9PNFNIdlp4?=
 =?utf-8?B?cnQ4eXdCRVVhNjdFQXlvbi9qSi9RbE5nRWl3cmFZcDYyWjFsQ25FakkxbC9O?=
 =?utf-8?B?dEo4MXFVeUovaUJrMWRGdytXdlNVMGpsTzArR2hsblBmdlRXQm1QZ2wvZ0RB?=
 =?utf-8?B?ZUx2UjRnVlRWcjg3SzNSUEViMWh4TmNuZDVtNjYzZTROUUR5MlZjK091dDQw?=
 =?utf-8?B?RzRlS3dQR2lYUXhva1pCZzZPaHRVZGJ6YVFtUVlPcU9RNWJabk9EbFZQQVY4?=
 =?utf-8?B?bEFtdTFpK0ZaZ005RVlLU0VBTm9jSktpUnZEWHNqcytZN2F5SVZwQ0dmR3lr?=
 =?utf-8?B?TU8rWmdDaWdiRFBPcGw5VmtOdWpBb0VJaFBnaThCeFppWVI1ZjBJSnhFcHhv?=
 =?utf-8?B?S05ydzlLamxoaGdXSjM0dmZzNlYzTUpnTHRmRnF1eXpkd1NmMnU5WnZhWXlI?=
 =?utf-8?B?ZklTazNRWDBQY1ROdmtJWnQ4eXFQVE9NNENXRjAxbmZRN1BUa2NEbkJjSmxz?=
 =?utf-8?B?aDVlQWdObWs3MHRJVGZBTnQyaU1PRmVia2JMUTB4cm5qVFZQYWd3Mm5xOEhR?=
 =?utf-8?B?djl3eDdMMU0rYi9Qb1FzTHJ0d1BOaGFnOENmZ0RBYnlEdmt5amdNNXU0VitV?=
 =?utf-8?B?aTlLRGlNTHZKUFUwSFlTMDNkZ1lFUGtUY2N6WVprZ1VzeFFrN0lmdXB4aTNZ?=
 =?utf-8?B?dkhRWFFRVW1OSVhwL2k5MmdQMUJNVFY1ME9WSGREN0UvdEcxREh4aUVLWCtW?=
 =?utf-8?B?SVdMTUR2Z1NqSFBINWo5YkljSHhQWlo0QVgreUdpb2ltNVlLUEZHNkpxTDda?=
 =?utf-8?B?N05Jelg4ZzdvZFFQWjJpeTlPZCtOVUFMamVWSXlLNWIzRTVvUXV5MHZ2cS9L?=
 =?utf-8?B?Zk1OcWFmSXYwVWdPZzNlQUEwdkJqbUV4RndzNTU4MnVrZnMwU2RnUzZ2SmJU?=
 =?utf-8?B?QWVPS2lYTXNKMlVoY3V2YnF5QlpsZDV2RGVxN1JhOEVyZ2lCcGlxYmJXZC9S?=
 =?utf-8?B?UzM0b1VsOG43NkNmM3dUYSs5bjJHaDlMNFlpMXBpOGt4dnFSQlU3V1Z1SEdU?=
 =?utf-8?B?YzA4M0xva3hsYUZBYUdvQzg1Y0FWdWJwYnhxNjdHYllFVHE0NjNKTzFCRFVL?=
 =?utf-8?B?Wjltb0wwTUdvZWdkUkJxSHlWUEd5ZEpQRDFXYnZBalhjSnYwUm5BRUk2U2po?=
 =?utf-8?B?WGt5RXV4aFhCc2xYaVdDYVZ1dWFEY1ZvUmV3b0VMU1NHYi9jeHorUE1hSVpq?=
 =?utf-8?B?Z0tGd2lSL3dQRUJaZnZ1Nm1pTTFQZEQ3RXVhR3ZFazFxNkZ2bVQzSU1YaTBn?=
 =?utf-8?B?aWEra1ZoNXc1Y2dMdGN6WFRLVUZaUks3ejY0dmhyeGwxVTA4RStINUNaRVJo?=
 =?utf-8?B?Z2theXFXUnFqRE42VHAyK2JjMjNVOW5HUVlqalhBM1cwWFpVRmpYRVdnUDM0?=
 =?utf-8?B?NGZIcVR6QWk2d3VuOXdKcXBxZmFVckJhRDFzVkhzcU5velBZVFFSQ293OUdV?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Bq7dJ3//QEoRuyv6fEGiZXnDbHCYD4s+z/iyXlSG6eSjTN26ib7nZegLMwa/MUjbcwJLoLp3DUmQF7/6asZnN9zwvozIXS8bUhQ45Jlv0e3Mc7R16ZYS8OZQF+oCr/rSjWBMwuDvmZs2iDBileyrgemdcyyWS1nJ/rCOTOLg3fobYz3k9viSGa5A99mJeBGThJip7GoxZ/68FEXz9c8JZztRieD0ByO41Zs4ENULvLZ/ZZx9zt9nNvI5MNHTg+E71fZc4Fqi9xEGHX06OnPKHGaZQOlbaL6r+Nyq1yYeKTI957i9+JwUNJlbvw1Tzo2LCs4KOP5QM36udMHwwBvgnvDG6g7XpojNZ4BMDX9rPjsYsj8lATAV6NdN89F4B9j+IvkipScEXGbA69l2LClwdc3TDlzU/PlxtraZquGqDHzx+smt8wX2khlzGxB4GITX9JVf6V1GNEn3yiS0rmuPSq32nBtJYSuBln/ccax65WGX2o+ydtWVqeGacLaa8qYYEPt1EbEAYbDWucHd5hy1AXJzqyMuYP17oBuhqTVlDsL7rHyVd7D1qrSYfLJ5OWW7WfA3iI7//pQk/cM0DjmpOx0UInGCfkID3M2J+aJUc9M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd000b4-1a15-4b21-68b9-08dc1100a7fc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 10:49:29.9438
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DPSKiE9dsqZpqGBHK4h9mtv8wHkFTvBzswvzZq2uE2WKDfrOR4os15kce/3CrjZUqdIHn4UNjsaEQ4M6gP4xepZHf2qCdhTnN40jlZSRO+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5300
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_03,2024-01-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090087
X-Proofpoint-GUID: t9TZEF5QrqPbdUcOEksgtZf43tgfNBnG
X-Proofpoint-ORIG-GUID: t9TZEF5QrqPbdUcOEksgtZf43tgfNBnG


> On Fri, Jan 5, 2024 at 1:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.co=
m> wrote:
>>
>> On Mon, 2023-12-25 at 12:33 -0800, Alexei Starovoitov wrote:
>> [...]
>> > It turned out there are indeed a bunch of redundant shifts
>> > when u32 or s32 is passed into "r" asm constraint.
>> >
>> > Strangely the shifts are there when compiled with -mcpu=3Dv3 or v4
>> > and no shifts with -mcpu=3Dv1 and v2.
>> >
>> > Also weird that u8 and u16 are passed into "r" without redundant shift=
s.
>> > Hence I found a "workaround": cast u32 into u16 while passing.
>> > The truncation of u32 doesn't happen and shifts to zero upper 32-bit
>> > are gone as well.
>> >
>> > https://godbolt.org/z/Kqszr6q3v
>>
>> Regarding unnecessary shifts.
>> Sorry, a long email about minor feature/defect.
>>
>> So, currently the following C program
>> (and it's variations with implicit casts):
>>
>>     extern unsigned long bar(void);
>>     void foo(void) {
>>       asm volatile ("%[reg] +=3D 1"::[reg]"r"((unsigned)bar()));
>>     }
>>
>> Is translated to the following BPF:
>>
>>     $ clang -mcpu=3Dv3 -O2 --target=3Dbpf -mcpu=3Dv3 -c -o - t.c | llvm-=
objdump --no-show-raw-insn -d -
>>
>>     <stdin>:    file format elf64-bpf
>>
>>     Disassembly of section .text:
>>
>>     0000000000000000 <foo>:
>>            0:   call -0x1
>>            1:   r0 <<=3D 0x20
>>            2:   r0 >>=3D 0x20
>>            3:   r0 +=3D 0x1
>>            4:   exit
>>
>> Note: no additional shifts are generated when "w" (32-bit register)
>>       constraint is used instead of "r".
>>
>> First, is this right or wrong?
>> ------------------------------
>>
>> C language spec [1] paragraph 6.5.4.6 (Cast operators -> Semantics) says
>> the following:
>>
>>   If the value of the expression is represented with greater range or
>>   precision than required by the type named by the cast (6.3.1.8),
>>   then the cast specifies a conversion even if the type of the
>>   expression is the same as the named type and removes any extra range
>>   and precision.                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>   ^^^^^^^^^^^^^
>>
>> What other LLVM backends do in such situations?
>> Consider the following program translated to amd64 [2] and aarch64 [3]:
>>
>>     void foo(void) {
>>       asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned long)  bar())=
); // 1
>>       asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned int)   bar())=
); // 2
>>       asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned short) bar())=
); // 3
>>     }
>>
>> - for amd64 register of proper size is selected for `reg`;
>> - for aarch64 warnings about wrong operand size are emitted at (2) and (=
3)
>>   and 64-bit register is used w/o generating any additional instructions=
.
>>
>> (Note, however, that 'arm' silently ignores the issue and uses 32-bit
>>  registers for all three points).
>>
>> So, it looks like that something of this sort should be done:
>> - either extra precision should be removed via additional instructions;
>> - or 32-bit register should be picked for `reg`;
>> - or warning should be emitted as in aarch64 case.
>>
>> [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf
>> [2] https://godbolt.org/z/9nKxaMc5j
>> [3] https://godbolt.org/z/1zxEr5b3f
>>
>>
>> Second, what to do?
>> -------------------
>>
>> I think that the following steps are needed:
>> - Investigation described in the next section shows that currently two
>>   shifts are generated accidentally w/o real intent to shed precision.
>>   I have a patch [6] that removes shifts generation, it should be applie=
d.
>> - When 32-bit value is passed to "r" constraint:
>>   - for cpu v3/v4 a 32-bit register should be selected;
>>   - for cpu v1/v2 a warning should be reported.
>
> Thank you for the detailed analysis.
>
> Agree that llvm fix [6] is a necessary step, then
> using 'w' in v3/v4 and warn on v1/v2 makes sense too,
> but we have this macro:
> #define barrier_var(var) asm volatile("" : "+r"(var))
> that is used in various bpf production programs.
> tetragon is also a heavy user of inline asm.
>
> Right now a full 64-bit register is allocated,
> so switching to 'w' might cause unexpected behavior
> including rejection by the verifier.
> I think it makes sense to align the bpf backend with arm64 and x86,
> but we need to broadcast this change widely.
>
> Also need to align with GCC. (Jose cc-ed)

GCC doesn't have an integrated assembler, so using -masm=3Dpseudoc it just
compiles the program above to:

  foo:
  	call bar
  	r0 +=3D 1
	exit

Also, at the moment we don't support a "w" constraint, because the
assembly-like assembly syntax we started with implies different
instructions that interpret the values stored in the BPF 64-bit
registers as 32-bit or 64-bit values, i.e.

  mov %r1, 1
  mov32 %r1, 1

But then the pseudo-c assembly syntax (that we also support) translates
some of the semantics of the instructions to the register names,
creating the notion that BPF actually has both 32-bit registers and
64-bit registers, i.e.

  r1 +=3D 1
  w1 +=3D 1

In GCC we support both assembly syntaxes and currently we lack the
ability to emit 32-bit variants in templates like "%[reg] +=3D 1", so I
suppose we can introduce a "w" constraint to:

1. When assembly-like assembly syntax is used, expect a 32-bit mode to
   match the operand and warn about operand size overflow whenever
   necessary.  Always emit "%r" as the register name.

2. When pseudo-c assembly syntax is used, expect a 32-bit mode to match
   the operand and warn about operand size overflow whenever necessary,
   and then emit "w" instead of "r" as the register name.

> And, the most importantly, we need a way to go back to old behavior,
> since u32 var; asm("...":: "r"(var)); will now
> allocate "w" register or warn.

Is it really necessary to change the meaning of "r"?  You can write
templates like the one triggering this problem like:

  asm volatile ("%[reg] +=3D 1"::[reg]"w"((unsigned)bar()));

Then the checks above will be performed, driven by the particular
constraint explicitly specified by the user, not driven by the type of
the value passed as the operand.

Or am I misunderstanding?

> What should be the workaround?
>
> I've tried:
> u32 var; asm("...":: "r"((u64)var));
>
> https://godbolt.org/z/n4ejvWj7v
>
> and x86/arm64 generate 32-bit truction.
> Sounds like the bpf backend has to do it as well.
> We should be doing 'wX=3DwX' in such case (just like x86)
> instead of <<=3D32 >>=3D32.
>
> I think this should be done as a separate diff.
> Our current pattern of using shifts is inefficient and guaranteed
> to screw up verifier range analysis while wX=3DwX is faster
> and more verifier friendly.
> Yes it's still not going to be 1-1 to old (our current) behavior.
>
> We probably need some macro (like we did for __BPF_CPU_VERSION__)
> to identify such fixed llvm, so existing users with '(short)'
> workaround and other tricks can detect new vs old compiler.
>
> Looks like we opened a can of worms.
> Aligning with x86/arm64 makes sense, but the cost of doing
> the right thing is hard to estimate.
>
>>
>> Third, why two shifts are generated?
>> ------------------------------------
>>
>> (Details here might be interesting to Yonghong, regular reader could
>>  skip this section).
>>
>> The two shifts are result of interaction between two IR constructs
>> `trunc` and `asm`. The C program above looks as follows in LLVM IR
>> before machine code generation:
>>
>>     declare dso_local i64 @bar()
>>     define dso_local void @foo(i32 %p) {
>>     entry:
>>       %call =3D call i64 @bar()
>>       %v32 =3D trunc i64 %call to i32
>>       tail call void asm sideeffect "$0 +=3D 1", "r"(i32 %v32)
>>       ret void
>>     }
>>
>> Initial selection DAG:
>>
>>     $ llc -debug-only=3Disel -march=3Dbpf -mcpu=3Dv3 --filetype=3Dasm -o=
 - t.ll
>>     SelectionDAG has 21 nodes:
>>       ...
>>       t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
>>    !     t11: i32 =3D truncate t10
>>    !    t15: i64 =3D zero_extend t11
>>       t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t15
>>         t19: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=3D=
 1', MDNode:ch<null>,
>>                          TargetConstant:i64<1>, TargetConstant:i32<13108=
1>, Register:i64 %1, t17:1
>>       ...
>>
>> Note values t11 and t15 marked with (!).
>>
>> Optimized lowered selection DAG for this fragment:
>>
>>     t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
>>   !   t22: i64 =3D and t10, Constant:i64<4294967295>
>>     t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t22
>>       t19: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=3D 1=
', MDNode:ch<null>,
>>                        TargetConstant:i64<1>, TargetConstant:i32<131081>=
, Register:i64 %1, t17:1
>>
>> Note (zext (truncate ...)) converted to (and ... 0xffff_ffff).
>>
>> DAG after instruction selection:
>>
>>     t10: i64,ch,glue =3D CopyFromReg t8:1, Register:i64 $r0, t8:2
>>   !     t25: i64 =3D SLL_ri t10, TargetConstant:i64<32>
>>   !   t22: i64 =3D SRL_ri t25, TargetConstant:i64<32>
>>     t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t22
>>       t23: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=3D 1=
', MDNode:ch<null>,
>>                        TargetConstant:i64<1>, TargetConstant:i32<131081>=
, Register:i64 %1, t17:1
>>
>> Note (and ... 0xffff_ffff) converted to (SRL_ri (SLL_ri ...)).
>> This happens because of the following pattern from BPFInstrInfo.td:
>>
>>     // 0xffffFFFF doesn't fit into simm32, optimize common case
>>     def : Pat<(i64 (and (i64 GPR:$src), 0xffffFFFF)),
>>               (SRL_ri (SLL_ri (i64 GPR:$src), 32), 32)>;
>>
>> So, the two shift instructions are result of translation of (zext (trunc=
 ...)).
>> However, closer examination shows that zext DAG node was generated
>> almost by accident. Here is the backtrace for when this node was created=
:
>>
>>     Breakpoint 1, llvm::SelectionDAG::getNode (... Opcode=3D202) ;; 202 =
is opcode for ZERO_EXTEND
>>         at .../SelectionDAG.cpp:5605
>>     (gdb) bt
>>     #0  llvm::SelectionDAG::getNode (...)
>>         at ...SelectionDAG.cpp:5605
>>     #1  0x... in getCopyToParts (..., ExtendKind=3Dllvm::ISD::ZERO_EXTEN=
D)
>>         at .../SelectionDAGBuilder.cpp:537
>>     #2  0x... in llvm::RegsForValue::getCopyToRegs (... PreferredExtendT=
ype=3Dllvm::ISD::ANY_EXTEND)
>>         at .../SelectionDAGBuilder.cpp:958
>>     #3  0x... in llvm::SelectionDAGBuilder::visitInlineAsm(...)
>>         at .../SelectionDAGBuilder.cpp:9640
>>         ...
>>
>> The stack frame #2 is interesting, here is the code for it [4]:
>>
>>     void RegsForValue::getCopyToRegs(SDValue Val, SelectionDAG &DAG,
>>                                      const SDLoc &dl, SDValue &Chain, SD=
Value *Glue,
>>                                      const Value *V,
>>                                      ISD::NodeType PreferredExtendType) =
const {
>>                                                    ^
>>                                                    '-- this is ANY_EXTEN=
D
>>       ...
>>       for (unsigned Value =3D 0, Part =3D 0, e =3D ValueVTs.size(); Valu=
e !=3D e; ++Value) {
>>         ...
>>                                                    .-- this returns true
>>                                                    v
>>         if (ExtendKind =3D=3D ISD::ANY_EXTEND && TLI.isZExtFree(Val, Reg=
isterVT))
>>           ExtendKind =3D ISD::ZERO_EXTEND;
>>
>>                                .-- this is ZERO_EXTEND
>>                                v
>>         getCopyToParts(..., ExtendKind);
>>         Part +=3D NumParts;
>>       }
>>       ...
>>     }
>>
>> The getCopyToRegs() function was called with ANY_EXTEND preference,
>> but switched to ZERO_EXTEND because TLI.isZExtFree() currently returns
>> true for any 32 to 64-bit conversion [5].
>> However, in this case this is clearly a mistake, as zero extension of
>> (zext i64 (truncate i32 ...)) costs two instructions.
>>
>> The isZExtFree() behavior could be changed to report false for such
>> situations, as in my patch [6]. This in turn removes zext =3D>
>> removes two shifts from final asm.
>> Here is how DAG/asm look after patch [6]:
>>
>>     Initial selection DAG:
>>       ...
>>       t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
>>   !   t11: i32 =3D truncate t10
>>       t16: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t10
>>         t18: ch,glue =3D inlineasm t16, TargetExternalSymbol:i64'$0 +=3D=
 1', MDNode:ch<null>,
>>                          TargetConstant:i64<1>, TargetConstant:i32<13108=
1>, Register:i64 %1, t16:1
>>       ...
>>
>> Final asm:
>>
>>     ...
>>     # %bb.0:
>>         call bar
>>         #APP
>>         r0 +=3D 1
>>         #NO_APP
>>         exit
>>     ...
>>
>> Note that [6] is a very minor change, it does not affect code
>> generation for selftests at all and I was unable to conjure examples
>> where it has effect aside from inline asm parameters.
>>
>> [4] https://github.com/llvm/llvm-project/blob/365fbbfbcfefb8766f7716109b=
9c3767b58e6058/llvm/lib/CodeGen/SelectionDAG/SelectionDAGBuilder.cpp#L937C1=
0-L937C10
>> [5] https://github.com/llvm/llvm-project/blob/6f4cc1310b12bc59210e4596a8=
95db4cb9ad6075/llvm/lib/Target/BPF/BPFISelLowering.cpp#L213C21-L213C21
>> [6] https://github.com/llvm/llvm-project/commit/cf8e142e5eac089cc786c671=
a40fef022d08b0ef
>>


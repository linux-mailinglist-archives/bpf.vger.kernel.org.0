Return-Path: <bpf+bounces-19258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C09B38285D5
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 13:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15EF5B21673
	for <lists+bpf@lfdr.de>; Tue,  9 Jan 2024 12:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C572374FE;
	Tue,  9 Jan 2024 12:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bv+8lY9U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qBL8Au3J"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA1374EB
	for <bpf@vger.kernel.org>; Tue,  9 Jan 2024 12:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409BxSF4012554;
	Tue, 9 Jan 2024 12:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=2X7WL8oPYY2Kqn//7dWkvzA+NYmrouN7TtVzPC1PxMQ=;
 b=bv+8lY9UwgFBXH0ZpAx4PO5GYoqqG70yRhW99cecET3yGdBB/+LikJ4VhNAh2zcdE9Hl
 j5AtDj94SwKLdC304AO6Ea2ntdwSx+5eqoMeXH+Aev9PO1Tr2FQDFFEnFlXPCnJTmqy8
 /O8n8TrNhg+ahgO/SVbnCriWCOuTiP8lKoidu43j4lCXLsnGv1gYRiBg2AV5Y1GvyLFP
 UtKO8Rqh/s20BQb80H2n5kn+o2sjicdPNLuUx55QZV/jlwOjDOaCCpCdlegCtiS99LI5
 oObjAJVRtx09UFDnzn4YzSe8P/fATuBIvZ38hgAW+Hu1CJ4fxe6I5T9CFmRhzThmauHu 6w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3vh5rf018c-6
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 12:13:53 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 409BLRRf030210;
	Tue, 9 Jan 2024 12:09:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3vfutkw30g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 12:09:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F0Oal/QTOQwyu2L/zC79Cfw3GePnBOG489OnK45jAj9ZuD51MyL36pcxhRjxwsfPGVFHBH3YFqHRH84VrOhWpe6j8cTl7f2pFIDO2TrlXUKUZrtXTgzjBzFJyNSZlOxuNV5pPOlf2UairziUAHHX7oPww4l/AuV4Wz9jUrKexdyzJXwVOslXV3R21NuILx/6Vvdns5Me1s57AoFLXH5SdjfLPpL0W2zHvDW6A5AC/5SHFtNh4Uv9lDCkaxeMw/t/APsOw0ZfOnPPPt5ryC/MsGNs/fHJdvZ8JPgNFdV2QX1t7akG/KXdfBD4Ket2wkcr0oU01DXoFZkOoVWrm7AdUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2X7WL8oPYY2Kqn//7dWkvzA+NYmrouN7TtVzPC1PxMQ=;
 b=NU7EM4plB4D7QVGPYgGZ0V12+GpMsKP2n73pZnQx8RuVjJN1/Zc+GLSNTodNUPVyHMGhKAsWj4fT3X/zQxYvjL7QCOezZ8lGaGw6OUhAoJ6YkWfKqcYbpgEfHye7IwBJ2JqmiWDnIRzodFno+ob+IcMkhRsjr08inKZG15FulLf+1zfECMJGghcfPUVDTm3l7U4R8vpiqJCSlOLtmeUAE5vU/1bljAYKayF3CXOpkYAnrLLP9RlUXtXjOGtERRA9GmjahF8RImH8F0PsJS4HNaSMSILN7Ps91yGZ/c5yQMa3bh3pseiS8quCAowbiRoBwzMbLz/FeyUaTECPPZ/4kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2X7WL8oPYY2Kqn//7dWkvzA+NYmrouN7TtVzPC1PxMQ=;
 b=qBL8Au3JeG6kpBAT9goR/3dYegN5d5LauW9C+CvP4uDRd4+gWk2OdG84sreQokbZHpH5VkyskxYbj+z9nXFN4SGVjp/rvGIHlXfHpR8Fe+WzSierZqKPp/oQKBkuF3FawQif1M3VSMiLgRIBxBtCGBbAn0TOFztxsDL+0btSD7I=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by MN0PR10MB5910.namprd10.prod.outlook.com (2603:10b6:208:3d2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 12:09:28 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::a45d:77b4:ce0c:9146%7]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 12:09:28 +0000
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
In-Reply-To: <87h6jm6atm.fsf@oracle.com> (Jose E. Marchesi's message of "Tue,
	09 Jan 2024 11:49:25 +0100")
References: <20231221033854.38397-1-alexei.starovoitov@gmail.com>
	<20231221033854.38397-3-alexei.starovoitov@gmail.com>
	<CAP01T77fbW-9N+Z-2LFS=174HN6v_OJAbR_s6EOfLLW8Oceh_g@mail.gmail.com>
	<CAADnVQKY4hB4quJX_oyq4GULEJkehXWx6uW1nAYHveyvdyG8sw@mail.gmail.com>
	<CAADnVQ+tYBpt_aRG5aU3sAYEysKxUOKQ24dBG4bP2kLy8nmmgA@mail.gmail.com>
	<44a9223b6638673487850eb9d70cc01ef58e9d93.camel@gmail.com>
	<CAADnVQLmXxn9RrniktuW80XO14oyOmgJ_NboBBC_-CU4O=-v9g@mail.gmail.com>
	<87h6jm6atm.fsf@oracle.com>
Date: Tue, 09 Jan 2024 13:09:24 +0100
Message-ID: <87mste4sjv.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0550.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::20) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|MN0PR10MB5910:EE_
X-MS-Office365-Filtering-Correlation-Id: dae55302-945d-446b-6eca-08dc110bd411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	QQZ+t2qo39QSh8zfRleQdkAfh2sMf68p0DpGCGM8uj94Dfhh/MKtt/HpqQ5lbhNluD5AP2YjIY1OGdr72OMOptscY9a30QBcwZ55YwbkmTbdrpoMhhipENgLwgpzqtVFvBmPMIeFlW2l7tMRRcvav0mP3Y9yL8QXcVGWmxo9iskr2dNcTw1LwoQ8Pn9iPqq6ZGwTSs9Tuqfn1xKU+QoNOn1k8BFL7gke9BOSDiy4G+MOYCpjMOR0wGxahzM0y+0l+tafazc+ZToSN7w3L9C/rlq6M6W8tOF7puMdEhbg6N+Vyv3ofaOLvtbIcqB8FY06mgm2rAZZwuLmM9GLgl2AQ6InulQopYoU02ggM4sv5y/7bRVPscQrKPG0iWzUoy/9qS5TGhL5K1oTjAhFtLBp4coeE+Ry9W1mRIohyC/dlaHzKyI1SrzAEfttYaVM437mW7kUvz7k7R8RxF180LJbQbevrAsEzC7rBGfiKHlIn/cIDZuhDzDNeXuOdIZ+DBGJxksC5MUgX5IvQqPTfDj7z1p1uJ/m1uZ8SM1kUo9hraXcA2tC6ieGS7ScXpysZLlqMtVXsX/zNba1tfalDCxvqOh0jb3WBTNUALdMdQRqekIsqy8cfqfdRj9f2dU2XWfO
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(366004)(376002)(136003)(230922051799003)(230273577357003)(230173577357003)(451199024)(64100799003)(1800799012)(186009)(7416002)(30864003)(5660300002)(478600001)(966005)(6666004)(6486002)(8936002)(6512007)(2616005)(86362001)(6506007)(53546011)(8676002)(41300700001)(66556008)(316002)(54906003)(66476007)(66946007)(6916009)(36756003)(38100700002)(83380400001)(26005)(4326008)(2906002)(4001150100001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eWpjRkFtNWZaYS9VazJScGxmVlpidHAzT3RkdXVFdkR3U1huTzAyZXVxTUx1?=
 =?utf-8?B?NWswczZzL3FtN2kzbnk4eWhnOWdhaS9BejFaMkNGbEg1TndTNnM5TnZhNHRF?=
 =?utf-8?B?WS9qVWdnM3dVdTVMYldaTUhqZTJVU1RFZEhERXM3ci9MMUltTXJjRkRQakd4?=
 =?utf-8?B?eXNtTXZRWE4xSzAzRlRCZTNVY1U1OVlXcnN1TXNLN0ZWOEdzNndvMnlwUEwx?=
 =?utf-8?B?MGRoblA4VyswQjYrdGFuWS95Ym01WDJDS05sS1FIa0w5MzhtdnhRc1JDK0Ex?=
 =?utf-8?B?ZUFzQW9HTjA4eGt6UzQ4eHNvNE1EMjRNaWxBK2s1REMzVFh0SXJZWlJ1emN4?=
 =?utf-8?B?Y00rWk5ueW9ud08wRVhhWXZIUnhXQjlPbktMYy9TTGRBSDhJVDhrZnpGaXFU?=
 =?utf-8?B?dDIyRWRMSEpGY054RGRWeTNoWDNOTjBOSXZLMUxsZHlmOEUzYmtEbUNvWEE1?=
 =?utf-8?B?cUVVMDRmTmlWZUNRcWNIM1I5eGZQZGxsdXFPVFZMY1RURU0rSldxdVpUUTR5?=
 =?utf-8?B?TFNtTzNoZ0xTeThabkdxT0lxSDRXVXF1YTA5aDJrSXYwUWxQcXMzUVBuODAy?=
 =?utf-8?B?OUxJdmhLZzJiNHNaK05FRlZ1QUNkaGowZFRQM2FkcTVlWWdGazJtZ3FiMWRP?=
 =?utf-8?B?YTRqOXpNcHVDUzZtSzNTRU53UDJsWTExc2ZXZ3ZPcUdBNVNwM3FYYWtpMGRz?=
 =?utf-8?B?MDNHQWlUTngzUThteGdDM29lZVQ0TGlBeW9yUElveGdBU1l2ZkhpMDRWMEI3?=
 =?utf-8?B?NkZjRVQ4cWJEZVBTMnIxTlpPYWxTSUNHcHFNSGlZZjRVZDh5UDBHZFNMRWkv?=
 =?utf-8?B?OVJzOERIMXhNRjQ0dlVsQmF5Vi9TUGlJb05ycTZUNURwVlJLR1hLM2thc2tl?=
 =?utf-8?B?b3Y3cVhPN0RjeE5Wc3lMNzhvZGowWUs1UmVSd1VNR1ZkQk9lLzZRZUpERU13?=
 =?utf-8?B?M2VRWW55ZDdNNk9na0xBVTdjckdoeVlqVjFRVTVmZ0xCM2RGSTdTUXR0RXZQ?=
 =?utf-8?B?ZU43V1B6alg4MEY0MUNPYWgrd0ZNN1BYckhCek05Um9DMEQ5S2NVVkw5bC9K?=
 =?utf-8?B?U0FhQXBNUy9VdWhTbzBlcFc1dmRUTEdtQlJmcjVGMjlCUWEybzZFUGxpeUto?=
 =?utf-8?B?MWR6NGM2RUdBc3VZRWYwYkRQTTQ2YnEvRVkrblJCendCOElIVHc1QUFSN09i?=
 =?utf-8?B?bEVHMEZWUDk4Qzl5anAzTHliSFYwbisyZHI0U3cxYzNrNVhHMXQyVVFLM3Qx?=
 =?utf-8?B?bE5DLzYvL1g1ZFBFUkxyMFBFaGcxZDNRcStYU0RBSE52REl3c1o2SzcwejZj?=
 =?utf-8?B?L2oyQ0NRVXdRRFNCQ2tPeWZqRnZzaTdCdjcvTm0zbG0vY2hSenVaazFGWjZF?=
 =?utf-8?B?aWEwaWZHSkhkbDRVK29CSlB0YlZ1NkdwL3lnMUFJWkhuViszd3prcVY5a0JC?=
 =?utf-8?B?eGhYTHNtTGdxUVo4V0YweHdLZHAzclBReE5BS1BjcEJ4VzFBKzdqeW1uNXBB?=
 =?utf-8?B?L243cHgxcjhkSmRIYmFpdmQxUmEvakhGakdqcFV0Ly9iVW5TTEdOdDhLU1I4?=
 =?utf-8?B?eDYxUStNczhjc1hIN3l2N0JBaW11UDVhV3NIZHVFZFIzSE1XT1B4UXRRd1ky?=
 =?utf-8?B?ZEdIS0lTMDR4bUpHc2pmb0hWYzhXOHllVUhqVFpybEQ5Zm53UmRhYk01M2Ey?=
 =?utf-8?B?UnBjaFFFRkh2WUZGeWdyTHZxK0wxbjVnSVNPK1laSHp0dFFkVC9TalpPVzIw?=
 =?utf-8?B?MFA4T1M2UWNEZS9GcVdmdkFLaEFpT2RmLzVYN0l0V0RFTzhFb0pDQk1WbmpX?=
 =?utf-8?B?RTlWSkRrNzY2M1ZyTFBEVXFzdnVZcDZPaHE3di9xNUx2TzVDNWFmUGs1OVls?=
 =?utf-8?B?T2lRYm02cEZlYTZxa0JUUXhQM1lRclBPc25nSDFxM0trVU03SXdmOFh5V0tQ?=
 =?utf-8?B?czh0VVpXZ2lycG05dEE2S3BFZG4vSmNyWDlUNTVldFRoTWllVTdsM2wyc240?=
 =?utf-8?B?QnN0aHZFWlRBcHh1WGlrT1NVb2RtSSt6YVZQSktlRzVNWXRINzlnTVk0cmpQ?=
 =?utf-8?B?cWNxK3pRWWRhOGR3bGxqRjdmbkFSY0RzR0pzbG9hZUpnb2NUMldiSEdSbk9a?=
 =?utf-8?B?ZEYxZjZ0OGQ2UGY0aHREZno1dnppMFpEQVdEZGpIZDBZSHlpRklCRUdkZkhu?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	3+it+K4CGKqWaeS6BKcFN9hgmBN9B/2ujovPyRSguEmH2MD916XFNNesopSS0oJXTvVetvocs40ZYschG2p7Xgr9Pxo7N5IOnfAoQqsbtxl4/vvPasWvy+fi7uWalBAzN5R73Qg0qehdqf2KkZuHQLxzEX169wt42Hzm7zpe+/kdVugkZKwyyXW4dPl43UyK8k+nXddQLnsfPGHepK26Dobgu8YnTx4bQzvJljzd/FORku0kqF9CzpXDsO0hCxpyC3HyX2HsZ72o/I1DtUzdbLq4s9McpCIWaEAbo7aJ6teet3tb2wDAHDFk0SDRThju1rYq+EThjyg08pIlpXgbaaTSCZQ+YomcA543TGv18kFsRO/tkTWFxmVnfitc22CtXkVWn8uCv3c8024Dh+CL9Ob03lvCmCqqg9P9/nKaoqDT2uwqyFJAuQosRWXo1DiWzIIpaD98tjfTZED/CuV1xzzK5xA2siGSv68+nXgSpUDIn1oizGv6YzyUkyjV9F7DLdcogHIqqwxkiIN4Kr8P7ZyUCtnnNIBDaYOGCgLPvF4qzl1TISMILDXgLip6guLBcYjZ1TuBlJfZvHA01QWl/XgUphSt2rZnvTcpsBa+rj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae55302-945d-446b-6eca-08dc110bd411
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2024 12:09:28.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RR+N5KnSvrLN3uaEoqQ3SfhODSTxATeisQCE/lr6uUmb8k9k7O3sZdi0CVxcQU4lMrbWxkPy3KCfqboTvLhbm63mqDjHsqDBTYg6Fa+Md48=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB5910
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_05,2024-01-09_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2401090099
X-Proofpoint-GUID: kKcsKQAyCUTHh6WhH8XXowzpaufH8qOf
X-Proofpoint-ORIG-GUID: kKcsKQAyCUTHh6WhH8XXowzpaufH8qOf


>> On Fri, Jan 5, 2024 at 1:47=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.c=
om> wrote:
>>>
>>> On Mon, 2023-12-25 at 12:33 -0800, Alexei Starovoitov wrote:
>>> [...]
>>> > It turned out there are indeed a bunch of redundant shifts
>>> > when u32 or s32 is passed into "r" asm constraint.
>>> >
>>> > Strangely the shifts are there when compiled with -mcpu=3Dv3 or v4
>>> > and no shifts with -mcpu=3Dv1 and v2.
>>> >
>>> > Also weird that u8 and u16 are passed into "r" without redundant shif=
ts.
>>> > Hence I found a "workaround": cast u32 into u16 while passing.
>>> > The truncation of u32 doesn't happen and shifts to zero upper 32-bit
>>> > are gone as well.
>>> >
>>> > https://godbolt.org/z/Kqszr6q3v
>>>
>>> Regarding unnecessary shifts.
>>> Sorry, a long email about minor feature/defect.
>>>
>>> So, currently the following C program
>>> (and it's variations with implicit casts):
>>>
>>>     extern unsigned long bar(void);
>>>     void foo(void) {
>>>       asm volatile ("%[reg] +=3D 1"::[reg]"r"((unsigned)bar()));
>>>     }
>>>
>>> Is translated to the following BPF:
>>>
>>>     $ clang -mcpu=3Dv3 -O2 --target=3Dbpf -mcpu=3Dv3 -c -o - t.c | llvm=
-objdump --no-show-raw-insn -d -
>>>
>>>     <stdin>:    file format elf64-bpf
>>>
>>>     Disassembly of section .text:
>>>
>>>     0000000000000000 <foo>:
>>>            0:   call -0x1
>>>            1:   r0 <<=3D 0x20
>>>            2:   r0 >>=3D 0x20
>>>            3:   r0 +=3D 0x1
>>>            4:   exit
>>>
>>> Note: no additional shifts are generated when "w" (32-bit register)
>>>       constraint is used instead of "r".
>>>
>>> First, is this right or wrong?
>>> ------------------------------
>>>
>>> C language spec [1] paragraph 6.5.4.6 (Cast operators -> Semantics) say=
s
>>> the following:
>>>
>>>   If the value of the expression is represented with greater range or
>>>   precision than required by the type named by the cast (6.3.1.8),
>>>   then the cast specifies a conversion even if the type of the
>>>   expression is the same as the named type and removes any extra range
>>>   and precision.                           ^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>>   ^^^^^^^^^^^^^
>>>
>>> What other LLVM backends do in such situations?
>>> Consider the following program translated to amd64 [2] and aarch64 [3]:
>>>
>>>     void foo(void) {
>>>       asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned long)  bar()=
)); // 1
>>>       asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned int)   bar()=
)); // 2
>>>       asm volatile("mov %[reg],%[reg]"::[reg]"r"((unsigned short) bar()=
)); // 3
>>>     }
>>>
>>> - for amd64 register of proper size is selected for `reg`;
>>> - for aarch64 warnings about wrong operand size are emitted at (2) and =
(3)
>>>   and 64-bit register is used w/o generating any additional instruction=
s.
>>>
>>> (Note, however, that 'arm' silently ignores the issue and uses 32-bit
>>>  registers for all three points).
>>>
>>> So, it looks like that something of this sort should be done:
>>> - either extra precision should be removed via additional instructions;
>>> - or 32-bit register should be picked for `reg`;
>>> - or warning should be emitted as in aarch64 case.
>>>
>>> [1] https://www.open-std.org/jtc1/sc22/wg14/www/docs/n3088.pdf
>>> [2] https://godbolt.org/z/9nKxaMc5j
>>> [3] https://godbolt.org/z/1zxEr5b3f
>>>
>>>
>>> Second, what to do?
>>> -------------------
>>>
>>> I think that the following steps are needed:
>>> - Investigation described in the next section shows that currently two
>>>   shifts are generated accidentally w/o real intent to shed precision.
>>>   I have a patch [6] that removes shifts generation, it should be appli=
ed.
>>> - When 32-bit value is passed to "r" constraint:
>>>   - for cpu v3/v4 a 32-bit register should be selected;
>>>   - for cpu v1/v2 a warning should be reported.
>>
>> Thank you for the detailed analysis.
>>
>> Agree that llvm fix [6] is a necessary step, then
>> using 'w' in v3/v4 and warn on v1/v2 makes sense too,
>> but we have this macro:
>> #define barrier_var(var) asm volatile("" : "+r"(var))
>> that is used in various bpf production programs.
>> tetragon is also a heavy user of inline asm.
>>
>> Right now a full 64-bit register is allocated,
>> so switching to 'w' might cause unexpected behavior
>> including rejection by the verifier.
>> I think it makes sense to align the bpf backend with arm64 and x86,
>> but we need to broadcast this change widely.
>>
>> Also need to align with GCC. (Jose cc-ed)
>
> GCC doesn't have an integrated assembler, so using -masm=3Dpseudoc it jus=
t
> compiles the program above to:
>
>   foo:
>   	call bar
>   	r0 +=3D 1
> 	exit
>
> Also, at the moment we don't support a "w" constraint, because the
> assembly-like assembly syntax we started with implies different
> instructions that interpret the values stored in the BPF 64-bit
> registers as 32-bit or 64-bit values, i.e.
>
>   mov %r1, 1
>   mov32 %r1, 1
>
> But then the pseudo-c assembly syntax (that we also support) translates
> some of the semantics of the instructions to the register names,
> creating the notion that BPF actually has both 32-bit registers and
> 64-bit registers, i.e.
>
>   r1 +=3D 1
>   w1 +=3D 1
>
> In GCC we support both assembly syntaxes and currently we lack the
> ability to emit 32-bit variants in templates like "%[reg] +=3D 1", so I
> suppose we can introduce a "w" constraint to:
>
> 1. When assembly-like assembly syntax is used, expect a 32-bit mode to
>    match the operand and warn about operand size overflow whenever
>    necessary.  Always emit "%r" as the register name.
>
> 2. When pseudo-c assembly syntax is used, expect a 32-bit mode to match
>    the operand and warn about operand size overflow whenever necessary,
>    and then emit "w" instead of "r" as the register name.
>
>> And, the most importantly, we need a way to go back to old behavior,
>> since u32 var; asm("...":: "r"(var)); will now
>> allocate "w" register or warn.
>
> Is it really necessary to change the meaning of "r"?  You can write
> templates like the one triggering this problem like:
>
>   asm volatile ("%[reg] +=3D 1"::[reg]"w"((unsigned)bar()));
>
> Then the checks above will be performed, driven by the particular
> constraint explicitly specified by the user, not driven by the type of
> the value passed as the operand.
>
> Or am I misunderstanding?

[I have just added a proposal for an agenda item to this week's BPF
 Office Hours so we can discuss about BPF sub-registers and compiler
 constraints, to complement this thread.]

>
>> What should be the workaround?
>>
>> I've tried:
>> u32 var; asm("...":: "r"((u64)var));
>>
>> https://godbolt.org/z/n4ejvWj7v
>>
>> and x86/arm64 generate 32-bit truction.
>> Sounds like the bpf backend has to do it as well.
>> We should be doing 'wX=3DwX' in such case (just like x86)
>> instead of <<=3D32 >>=3D32.
>>
>> I think this should be done as a separate diff.
>> Our current pattern of using shifts is inefficient and guaranteed
>> to screw up verifier range analysis while wX=3DwX is faster
>> and more verifier friendly.
>> Yes it's still not going to be 1-1 to old (our current) behavior.
>>
>> We probably need some macro (like we did for __BPF_CPU_VERSION__)
>> to identify such fixed llvm, so existing users with '(short)'
>> workaround and other tricks can detect new vs old compiler.
>>
>> Looks like we opened a can of worms.
>> Aligning with x86/arm64 makes sense, but the cost of doing
>> the right thing is hard to estimate.
>>
>>>
>>> Third, why two shifts are generated?
>>> ------------------------------------
>>>
>>> (Details here might be interesting to Yonghong, regular reader could
>>>  skip this section).
>>>
>>> The two shifts are result of interaction between two IR constructs
>>> `trunc` and `asm`. The C program above looks as follows in LLVM IR
>>> before machine code generation:
>>>
>>>     declare dso_local i64 @bar()
>>>     define dso_local void @foo(i32 %p) {
>>>     entry:
>>>       %call =3D call i64 @bar()
>>>       %v32 =3D trunc i64 %call to i32
>>>       tail call void asm sideeffect "$0 +=3D 1", "r"(i32 %v32)
>>>       ret void
>>>     }
>>>
>>> Initial selection DAG:
>>>
>>>     $ llc -debug-only=3Disel -march=3Dbpf -mcpu=3Dv3 --filetype=3Dasm -=
o - t.ll
>>>     SelectionDAG has 21 nodes:
>>>       ...
>>>       t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
>>>    !     t11: i32 =3D truncate t10
>>>    !    t15: i64 =3D zero_extend t11
>>>       t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t15
>>>         t19: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=
=3D 1', MDNode:ch<null>,
>>>                          TargetConstant:i64<1>, TargetConstant:i32<1310=
81>, Register:i64 %1, t17:1
>>>       ...
>>>
>>> Note values t11 and t15 marked with (!).
>>>
>>> Optimized lowered selection DAG for this fragment:
>>>
>>>     t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
>>>   !   t22: i64 =3D and t10, Constant:i64<4294967295>
>>>     t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t22
>>>       t19: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=3D =
1', MDNode:ch<null>,
>>>                        TargetConstant:i64<1>, TargetConstant:i32<131081=
>, Register:i64 %1, t17:1
>>>
>>> Note (zext (truncate ...)) converted to (and ... 0xffff_ffff).
>>>
>>> DAG after instruction selection:
>>>
>>>     t10: i64,ch,glue =3D CopyFromReg t8:1, Register:i64 $r0, t8:2
>>>   !     t25: i64 =3D SLL_ri t10, TargetConstant:i64<32>
>>>   !   t22: i64 =3D SRL_ri t25, TargetConstant:i64<32>
>>>     t17: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t22
>>>       t23: ch,glue =3D inlineasm t17, TargetExternalSymbol:i64'$0 +=3D =
1', MDNode:ch<null>,
>>>                        TargetConstant:i64<1>, TargetConstant:i32<131081=
>, Register:i64 %1, t17:1
>>>
>>> Note (and ... 0xffff_ffff) converted to (SRL_ri (SLL_ri ...)).
>>> This happens because of the following pattern from BPFInstrInfo.td:
>>>
>>>     // 0xffffFFFF doesn't fit into simm32, optimize common case
>>>     def : Pat<(i64 (and (i64 GPR:$src), 0xffffFFFF)),
>>>               (SRL_ri (SLL_ri (i64 GPR:$src), 32), 32)>;
>>>
>>> So, the two shift instructions are result of translation of (zext (trun=
c ...)).
>>> However, closer examination shows that zext DAG node was generated
>>> almost by accident. Here is the backtrace for when this node was create=
d:
>>>
>>>     Breakpoint 1, llvm::SelectionDAG::getNode (... Opcode=3D202) ;; 202=
 is opcode for ZERO_EXTEND
>>>         at .../SelectionDAG.cpp:5605
>>>     (gdb) bt
>>>     #0  llvm::SelectionDAG::getNode (...)
>>>         at ...SelectionDAG.cpp:5605
>>>     #1  0x... in getCopyToParts (..., ExtendKind=3Dllvm::ISD::ZERO_EXTE=
ND)
>>>         at .../SelectionDAGBuilder.cpp:537
>>>     #2  0x... in llvm::RegsForValue::getCopyToRegs (... PreferredExtend=
Type=3Dllvm::ISD::ANY_EXTEND)
>>>         at .../SelectionDAGBuilder.cpp:958
>>>     #3  0x... in llvm::SelectionDAGBuilder::visitInlineAsm(...)
>>>         at .../SelectionDAGBuilder.cpp:9640
>>>         ...
>>>
>>> The stack frame #2 is interesting, here is the code for it [4]:
>>>
>>>     void RegsForValue::getCopyToRegs(SDValue Val, SelectionDAG &DAG,
>>>                                      const SDLoc &dl, SDValue &Chain, S=
DValue *Glue,
>>>                                      const Value *V,
>>>                                      ISD::NodeType PreferredExtendType)=
 const {
>>>                                                    ^
>>>                                                    '-- this is ANY_EXTE=
ND
>>>       ...
>>>       for (unsigned Value =3D 0, Part =3D 0, e =3D ValueVTs.size(); Val=
ue !=3D e; ++Value) {
>>>         ...
>>>                                                    .-- this returns tru=
e
>>>                                                    v
>>>         if (ExtendKind =3D=3D ISD::ANY_EXTEND && TLI.isZExtFree(Val, Re=
gisterVT))
>>>           ExtendKind =3D ISD::ZERO_EXTEND;
>>>
>>>                                .-- this is ZERO_EXTEND
>>>                                v
>>>         getCopyToParts(..., ExtendKind);
>>>         Part +=3D NumParts;
>>>       }
>>>       ...
>>>     }
>>>
>>> The getCopyToRegs() function was called with ANY_EXTEND preference,
>>> but switched to ZERO_EXTEND because TLI.isZExtFree() currently returns
>>> true for any 32 to 64-bit conversion [5].
>>> However, in this case this is clearly a mistake, as zero extension of
>>> (zext i64 (truncate i32 ...)) costs two instructions.
>>>
>>> The isZExtFree() behavior could be changed to report false for such
>>> situations, as in my patch [6]. This in turn removes zext =3D>
>>> removes two shifts from final asm.
>>> Here is how DAG/asm look after patch [6]:
>>>
>>>     Initial selection DAG:
>>>       ...
>>>       t10: i64,ch,glue =3D CopyFromReg t8, Register:i64 $r0, t8:1
>>>   !   t11: i32 =3D truncate t10
>>>       t16: ch,glue =3D CopyToReg t10:1, Register:i64 %1, t10
>>>         t18: ch,glue =3D inlineasm t16, TargetExternalSymbol:i64'$0 +=
=3D 1', MDNode:ch<null>,
>>>                          TargetConstant:i64<1>, TargetConstant:i32<1310=
81>, Register:i64 %1, t16:1
>>>       ...
>>>
>>> Final asm:
>>>
>>>     ...
>>>     # %bb.0:
>>>         call bar
>>>         #APP
>>>         r0 +=3D 1
>>>         #NO_APP
>>>         exit
>>>     ...
>>>
>>> Note that [6] is a very minor change, it does not affect code
>>> generation for selftests at all and I was unable to conjure examples
>>> where it has effect aside from inline asm parameters.
>>>
>>> [4] https://github.com/llvm/llvm-project/blob/365fbbfbcfefb8766f7716109=
b9c3767b58e6058/llvm/lib/CodeGen/SelectionDAG/SelectionDAGBuilder.cpp#L937C=
10-L937C10
>>> [5] https://github.com/llvm/llvm-project/blob/6f4cc1310b12bc59210e4596a=
895db4cb9ad6075/llvm/lib/Target/BPF/BPFISelLowering.cpp#L213C21-L213C21
>>> [6] https://github.com/llvm/llvm-project/commit/cf8e142e5eac089cc786c67=
1a40fef022d08b0ef
>>>


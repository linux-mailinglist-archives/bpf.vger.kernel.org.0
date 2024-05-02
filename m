Return-Path: <bpf+bounces-28446-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 923D08B9C0C
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 16:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 469B4281D4C
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 14:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2320713C692;
	Thu,  2 May 2024 14:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VG0+VrBs";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c2QSFwDX"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED555C8F3
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714658922; cv=fail; b=RvBmQtUWx1nPPt2/PC34d2eL5hGmKqQ9quzIZMA61/oLry/IwYOgf4A3dhit1jeyyisHk2qrKdyQz/+51/5g/AygtecLrxR9xzJZqPN8Dw2YFMNjePSFl5mH4oiTre3zNgjGWu6M9pxIEDGh40hdA0uHQTv5apjAB53z4+aPcbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714658922; c=relaxed/simple;
	bh=bsewIYseCkU/hakCXOskwCENqnGVFNCfXObhAVDDSAU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Bmh/kBcEBWVzgFPxr4c5R10G55eY86+Vu/AEDCKisnK6p2bezO3KpHcF02LW63hk5ITARWuLCizEmSxT2bdaVZ1X2lDfR7jun6e1Ge4Hx9OZgVAX0meoeo3fH+GFeObMB6+qvT7XXg8YcHsNGxhZs8uA63Y2RuHaFQMFJrZ+P/Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VG0+VrBs; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c2QSFwDX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442E0nXj019965;
	Thu, 2 May 2024 14:08:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=UrXi0eIq1aOx9lFcrr5sPTFFlpKXyCLbLxVLetKjmKY=;
 b=VG0+VrBsbcz7yk16BBieAZg8MVPMiu3YmEJ05muVccP+kNY0ibG57ADUx+jl51R5eVlt
 l3Jc+EkNqCwkej5Vf1KhV05wlzSBr87BcjEkft/NZD64BRiCo8I6paKmlRggKs9/vyQ2
 G008w9M0o9rnzT+ZmD1/HuXSiD/7jO3bStUe0rdniW5u1xG9RaS+72Pd8ymK/AT7rfdT
 nSBOBgjM+aji98gGqZ7lCSyfogfPZYH0h2Cqp9F4XZtL0NhbNV3xn04yg+xseEgGnbKR
 WME9Gsm9K0BPsEIadmjqk60TM776tOMIp6FXJCbd/FFvdy+HBWMHQ1WowKjRG4kIIRbO RQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr9cxjvv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 14:08:39 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442CbFq7020015;
	Thu, 2 May 2024 14:08:38 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqtag079-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 14:08:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpVBo4+utvfwBnnl0sTLAIbd7aHQQf43sGPCxbMJuYY8kMmsnXSXxmatA5yGTLgSkqocgBl6R6BpDK9gmAs7Z0odpTGjAQWD5LA9wrji+l2fhMoXV2HJGeBQs5BoIziyDtqq0MmXbac5SAf/aTMdns3EdHfLdHolc2mG/RqAjID0VlCLvxAN1FIYa1+bcxKti5ALLwfNIAnqCn7BanzD6ciISH1PVb28v4KoCVhgoU2vzdXf9S42ReIFFjATc+4tDse9RPDOc4bZpeHeP+X55Uqi44Yv966sUS5ktUMjVu0XBMAH9ptJ/23GcmlAh96iNGh07bEliRTRTv+jCYMOiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UrXi0eIq1aOx9lFcrr5sPTFFlpKXyCLbLxVLetKjmKY=;
 b=JbGE5YwmGJZOQtEJjqxHK7O5eumT9+Gu2p9eSHiG4sCu+vCSt++EktluYu4NsPqTvPsQsDhG7qJQ3h+yfylxDxO7ZAg6thiGOCIZY9mDFlSk1MVbbFWOnongojaH/sC9ywbb0O0SZSCYpJIuNhEt7FLrt5l7o4qGZOCTge0x3/pGshjab0p64LRKFTqxCC0+AXVuHKuQWpAvD0jqOa7G931DE8IW/Ptf3LAi/8H3l75AVS9GVQDNM0JRHEvd9O7VCf7scqlcCEPwxqgfWvb257jpDhbyYmd96qFQHiUmoeEdI51hhm9jH1CQ1DjFyCxDXLUihNgiyfOuhnmiy+AecQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UrXi0eIq1aOx9lFcrr5sPTFFlpKXyCLbLxVLetKjmKY=;
 b=c2QSFwDXh983Wuqozv03QjVvoPL+YappcbHsuR6bI+feJm2O9iDWzHyQqQ+i1xgj/xwdFx0A8ziJYS8f4KjdTGdqXQArijS2Zog2Gyc2cdeq4NQbeiQysybpAqMpnQ8NNrPCOW/GHQz9B/rGDsUVmaSNZJ/Olk5l1V8K9rrOzGQ=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by CY8PR10MB7121.namprd10.prod.outlook.com (2603:10b6:930:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.29; Thu, 2 May
 2024 14:08:36 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 14:08:36 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next] bpf: missing trailing slash in tools/testing/selftests/bpf/Makefile
Date: Thu,  2 May 2024 16:08:31 +0200
Message-Id: <20240502140831.23915-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL6PEPF0001641A.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1004:0:6) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|CY8PR10MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: bc65700b-506e-42d2-e44a-08dc6ab15ba3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?38X5xePic1Hh32/2EwfqAYrRgZlkajrM0jxdKtsNsdNSyBM55oRqYajNqj0m?=
 =?us-ascii?Q?zjpFbIQit49yG4dB8TZZHvVTltfWjVXqgs5Qv3lKMoJuAN6HumONXj4dWuch?=
 =?us-ascii?Q?IOawamg0RWENA2ZDJTnL9HkvlEbYsmepCpB1ktxQPQfaVmkDFI3o0DpI4c6K?=
 =?us-ascii?Q?8Q/HVM4pagIwjqlW3swWVFf3OzFCcQrw5CqPBb63S6K7VlHMu1REAGYuxuNZ?=
 =?us-ascii?Q?hpQylEULTYK0alnWXKRWgbCSLoIVsd7bXXo5EYQpxs86+RYwgTHZMnWDKRaU?=
 =?us-ascii?Q?kxXgFF2e2li4Ma3CCG9iXrIb9MWY5+6hoQFsgmDbBDVO2EerNY2vRTTv8HAW?=
 =?us-ascii?Q?KByZ4EZRDYxvlxyvpNCfy7Wu/nHnszal+u0pO4nvUeHyZA3XExtVqkOMlBDi?=
 =?us-ascii?Q?uK1aMLZwzAcSq/f8yao2QFFv7e/TNlt1vprsfvsZWfCY2qs2eFR3l4uwemy5?=
 =?us-ascii?Q?hl7IC3QmkpXeOnlpmxSqqWAg+qZMubwbu8mRXENqF/sEX2xY1cLm2TwF42X6?=
 =?us-ascii?Q?sdzs18u4EqnauRiNl1e1TJJv6jDkrTzP6s+lnHTJEF12B296qXbTfbIZVqhC?=
 =?us-ascii?Q?SOFkLkrbrmNYuaCwv1bkljowDUlD5PStlIh7RK05VwzqPTX2Jh7j88l5z/t6?=
 =?us-ascii?Q?NBWa/ieNQWI3K3z5mvmycvpsxhOUnS4ZJhzBrtZjRPMdDFR4umVN0k6RPwoB?=
 =?us-ascii?Q?2bfXkjJhgCdGZhbqd+PT7fE5ws/HAHstdGmjRVQxgpe/k9mzFWWBHvaYFRvA?=
 =?us-ascii?Q?nwhBrlI8cbmMs20ilKtEROXGXC83RFqcMzNyecV2JguMuoiJK1l5xPF/7/HF?=
 =?us-ascii?Q?rqBbvC0B4c9mJe1By/uPypUlUHbbgAnho3jsYtwAQrb+xRLZv6I9XgHLuLHL?=
 =?us-ascii?Q?9KFKOtGMkntzSzEuGx5Qan7r2q9/uc+LQinlEndP3cNbRFb0jfDGsIaHU+O8?=
 =?us-ascii?Q?bqZvphwGx3djyvE/+Nyu4smmOczaRaRxxueYbjCus0NN0dqBzhmqx6Ege+mW?=
 =?us-ascii?Q?82LncC3KGUpstCMnluTAKwheq3kVsffjp4TtpY8PF/oyR64Q8WT6WgQkWIgo?=
 =?us-ascii?Q?8G0VbJ3gnWHQb0WCsxlRvaHgF2NFM7FN9Gl+0aXA82lhRQKbZ8z0Fmr0tktG?=
 =?us-ascii?Q?v45cPVBQGxWcKwWIZKszlaiZmA7KEXrPP2Tmb8GAIFKHXU8ETaprfcPveOYH?=
 =?us-ascii?Q?523EMKqrjDQa//kZ3srbBIyNTKVHZr05O/GWEIsEXeAsUfL2QI2rxsxjF2Y2?=
 =?us-ascii?Q?e3wI1mIGT69hAZcVZuYjA16O6gEJa5HMvzxhGyDLKg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?dCNYJdpWNzi2AHyUXqFya8p18COEKUpX0xaJmbDjNTqEicJ/auCRJcJFxYBi?=
 =?us-ascii?Q?6k3edTkEzbkz5be+4m9GgaTUumCHCnc4WXf0Zb+ZHBAuzldSok8mFAZI7fY3?=
 =?us-ascii?Q?6rlyOUmA2YOLKMt82rBiPC+YdkCxWPFmgj5MWNNSNIOPaTu6kkQHJg25/NiB?=
 =?us-ascii?Q?3vLvy2JME+sKeSOIpVjlmpE9IJGmbu2+qkYG/WQsuysFGXFUG9dTd7sw6XnH?=
 =?us-ascii?Q?2LjHHrU2AHJG0eU/NdNgOak9ORDu2UovIKLL3mqylvwFM0XpYjUxttcNatMx?=
 =?us-ascii?Q?/6b6U6TqSNWHnTXWLkf0gYxdM4rg4hJAb0iLAD4XfoszprpxLji/8Q79zYen?=
 =?us-ascii?Q?pPxfqQB995zV6D15SvnfuqVugSOvEg34xxmP4ROKFa68xORACYjB7+IM5cPG?=
 =?us-ascii?Q?sN9H7Gjb/z1Xi8tLf4hNq78mViJnutsgIV1+wGPAPzws2DJSsWahVKEHHWnb?=
 =?us-ascii?Q?zGhiZSkeAPx4l1vMYMiToalXzxvMAEXQtNdHBB5BvSHpsP3aBJe9RRdkschx?=
 =?us-ascii?Q?fzrByXUt4Fl3zYbwNtLZE3fVg+uE9TId/odU/5r7u670XfWxkSw9uobKrafo?=
 =?us-ascii?Q?I+Krsa8BNP0tg8YL9H3ubQJJXzkDOoG908jcTC49ovXFd8ek+ocphyXLXyw0?=
 =?us-ascii?Q?DrP9qF65ZsgMqu8cy4alMVjLNNcWNKgDTDZlGHf5rB7pc21uuZfT+YJtyORC?=
 =?us-ascii?Q?70qhNHwJy/XbQ2jgoH0iGz0MYL9LfOzxzpQzA+Eui8OiUv1aO2q4DOHh806A?=
 =?us-ascii?Q?y8kOoAxIRv6VCrj/gS7jK1SSxED8qTP26VPuJ8nO5oFFKN+9EHSbjhexDrqJ?=
 =?us-ascii?Q?Vn49G1MeI4texNKrPoeJIwCjLHj7gq9TdT8mk2Kl8yHcMQ4aTox/2jbnLg7e?=
 =?us-ascii?Q?xuabQuvOFXSRQPXitUEvOWGzcVMbCesJybg+yl9Hj0Wso4oxDgIvk07NWi51?=
 =?us-ascii?Q?d9SO9CFZ+qzGsd3AhBTeSx6uoZcR2Be4d6pSDeqRuEwKInvxENDNcpG+Vq9P?=
 =?us-ascii?Q?3iNo+nvA3J7A09smSsQBcmdkFp73SGL7FzxOOPO5C0DdHJu5HuzbVyI1ZK6o?=
 =?us-ascii?Q?zHGvB+2z/ivJnPvXdRBPH11ovg6kLSTUHPFkn5V8MW/FUPpDwVe5+Jc0IbwG?=
 =?us-ascii?Q?sT10w3DxrtK9lj2oB+0ocKZ8njiTxt7TF/TKW/mpFuTMYKGKT5bYZV731bVp?=
 =?us-ascii?Q?jpAoNiCb+qhfC0Jki+cCkgw1fQ665treKGBL9sYbleTgpqKdCJfEBD534zha?=
 =?us-ascii?Q?KSMUV2E8JXJv4yx4Yur++kDZCbqYqLsr4qMUyFBdQo8lMsiBldUqxJ+Vrfoj?=
 =?us-ascii?Q?IVsujSix3dLoHrI3fgX6hwUaamnoZleUXncoJ7+NH8Nhq/2jCf9vSBtkcIFI?=
 =?us-ascii?Q?4u1tCvFmLDjwd5ko3yuNE2JvQ/7fB/7shjGdKyVDThyfshnwxbK79iNTjEns?=
 =?us-ascii?Q?Gf/ax7Ri95A8rS/HjfdASNixOpKrEZXyj0iJwuIm0Y+anLOtuBxsMI6dL0Hm?=
 =?us-ascii?Q?uHLvqjLNiV4XjjoOQ5ARj3VmbaHRAHn5ZVcI9Dr3fqJlfBKQRWRHVBLErvOG?=
 =?us-ascii?Q?Qv7QfGvtZa9FLGsRd2UOlV7hIkVa0tKvLPdrpugkRGa0PzqyXkeasZrcQ60R?=
 =?us-ascii?Q?Gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	y6zoEzjIUjet3yZ4Q91wgoxYr4L/EGBaXHUHQi13uAHrUtmZUg2worFbq2ShbrDrOyJ+ZjrLAPxwqeR/rvutMqCfzq8frNUF6P7QvbS/gs1syULtcV3KdryRZ4GedmMa0ymGxWdks5Wh+LH2SfkcujK0Fo3SaiOLDJJqpoD87TaNOy1Sk3WSzUmaCIAyE33xcj8Sa2hiKQlNlw8KYMbchqxs+WJqelPyO78AXQi1laHU/yQofUEMLo/UlPPnqRf+v4Cxq0PrKQTKRUcw6oGBGGX3lMTpH7kstK59uvun0+rDDy6H+GBrDs1ZAeKeLKyNXdw5IyfFoWm0kg0/XGbE6pUqUn03PAHuKYWCtddMy7XcrVgUjdkgIoiJM/J4rAOBs1HFV00f78guuiBYDX/YA8frmTdg5Wf935PB7CKc/PtcS/1czV296ndNrp0288MdKXqZKtx9zWWIJ9J5QVDCTiw9j9ZXvVd3DjT2HE5HmaGQZ6rC1KRKvOryvoqFrwCZ/VZH63bxjRlXVJLF3Dq1FqyHx173DH6vwZUhf2NOMUc8dvGWyrBkxLyik2t2Vrsy+MdtKO7LkEk+meiEeBikiK5s8GiLaQIa60PmoK+h0eo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc65700b-506e-42d2-e44a-08dc6ab15ba3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 14:08:36.0633
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QoAkwr04gqRO/akBmTmAy4yQ0SMaQ3ajkS/vPfrVLD6PpvZLksotSoC0xhQpy7MDJxdBDQfHQhD9r7u/1TGvmPQbgIYXYvGOUZQ/MucO95A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7121
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_02,2024-05-02_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=769 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2405020091
X-Proofpoint-GUID: QsWxaolLP9mTGupQ3_oV_ZhSNjUHotsb
X-Proofpoint-ORIG-GUID: QsWxaolLP9mTGupQ3_oV_ZhSNjUHotsb

tools/lib/bpf/Makefile assumes that the patch in OUTPUT is a directory
and that it includes a trailing slash.  This seems to be a common
expectation for OUTPUT among all the Makefiles.

In the rule for runqslower in tools/testing/selftests/bpf/Makefile the
variable BPFTOOL_OUTPUT is set to a directory name that lacks a
trailing slash.  This results in a malformed BPF_HELPER_DEFS being
defined in lib/bpf/Makefile.

This problem becomes evident when a file like
tools/lib/bpf/bpf_tracing.h gets updated.

This patch fixes the problem by adding the missing slash in the value
for BPFTOOL_OUTPUT in the $(OUTPUT)/runqslower rule.

Regtested by running selftests in bpf-next master and building
samples/bpf programs.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 82247aeef857..ba28d42b74db 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -262,7 +262,7 @@ $(OUTPUT)/runqslower: $(BPFOBJ) | $(DEFAULT_BPFTOOL) $(RUNQSLOWER_OUTPUT)
 	$(Q)$(MAKE) $(submake_extras) -C $(TOOLSDIR)/bpf/runqslower	       \
 		    OUTPUT=$(RUNQSLOWER_OUTPUT) VMLINUX_BTF=$(VMLINUX_BTF)     \
 		    BPFTOOL_OUTPUT=$(HOST_BUILD_DIR)/bpftool/		       \
-		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf			       \
+		    BPFOBJ_OUTPUT=$(BUILD_DIR)/libbpf/			       \
 		    BPFOBJ=$(BPFOBJ) BPF_INCLUDE=$(INCLUDE_DIR)		       \
 		    EXTRA_CFLAGS='-g $(OPT_FLAGS) $(SAN_CFLAGS)'	       \
 		    EXTRA_LDFLAGS='$(SAN_LDFLAGS)' &&			       \
-- 
2.30.2



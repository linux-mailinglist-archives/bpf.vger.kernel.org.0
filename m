Return-Path: <bpf+bounces-1170-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9545E70F99E
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 17:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 645791C20D8F
	for <lists+bpf@lfdr.de>; Wed, 24 May 2023 15:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6674D19511;
	Wed, 24 May 2023 15:03:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700718C32
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 15:03:09 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58899C;
	Wed, 24 May 2023 08:03:07 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34OF02fv001670;
	Wed, 24 May 2023 15:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=TQFe2yaHFd+4McW1S1mt7B/3CYRr0RhdmH/c+O4fGo4=;
 b=tLMnC8dQ/0AomcPngoAi6GK8z2KL/p1lf5VyvL+Yk/75TeZ3NXlARfMQ8UWSIlwltUZk
 4W1ZFWV9G5cZTi7dqRCJg2IgR6khnk5ocanPsNfoPqKqxQKrv9BPTOaOE3G5u/pxp3BB
 SRCqyc2tNf5u1Hjs5OvkORRdjIaY7zKvqqyUNCbAg2kiP+ubf42pR2KQk3v8m/0qMATE
 //Q3HMfssjW+tDe1mGWpFLk49J9OAPMZsiuBlfQsjqkJ92IGK8J9Vfck5mnV+5iG2Xom
 0iSf+lZmVwJ2w+4bxAah7K/nemUVYNpCy0xblS297YyjjdMbRfFa9SRQffp1RAiem/Me vA== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qsmua007w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 May 2023 15:02:44 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34OE9Kjq013193;
	Wed, 24 May 2023 15:02:42 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2042.outbound.protection.outlook.com [104.47.57.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk7gcqsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 May 2023 15:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fq1A2U1CXJCvx7pRds9GKj6h3nhHRGnnhDjRT7K0P6R6ekPI2iqBf1VUoKcivpsArjVXrOYhsO84h3dfpLYOF9uwmZr5l3qh3lwc17RVgjlteiU5K6Dg5114vPxwDbhRqS9cYJFnsTvpHHCBOawAvmBd6/VdQwDDXQZVTFc9T8K63M2MRsJMN71BFT7cTTZZf06tVINmcM8W26V8wqp6pp7a/VBI+Uulf2Hn81WAjBuAZIPMxfP3y5cVxQPBp6ceO/YseA8kp7YQ6vS3p/Oxd5ywt/QYadEPoimHy40NMrapjEcdr8zZdp997r+1+hfJ3CxILybm1i6zS4V12382uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQFe2yaHFd+4McW1S1mt7B/3CYRr0RhdmH/c+O4fGo4=;
 b=MTirT4c/KaDb/nZGQs5TE20p3VF4MdxXxM9HguY2sPRxHqFIRHWsNgFv+EWE4Knq/31+pxorfXkJJ9F+o6UItG4sd6505aQCL+Y1T05/1+gx9YbUrTnHWbOwtcHiWStT91Nfx669LK9Vhal7oYUHS3VcaDblrg+OcQ+cGK1/jTjfGkeeqbeWVKdPZbXlolruOQApr7fPrFq/uZ9UM1KOGvvfGdpnICPmZh/Zj9tIN9tba/oRPNskazxuTf3/23c1cSD7uLWCbQJgluhCroHOBKvAKDB5MeKbqJSCTDkz31/LwrAMsZIpQx7TPdXWpkSaMVKazyNCzyoyQ2ziPPhTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQFe2yaHFd+4McW1S1mt7B/3CYRr0RhdmH/c+O4fGo4=;
 b=BRvuBPa4ninKat+NNGdKAivz+iEPgkVn6JEG75RbF1kEjqlgfThtQFz79p3VR6EmJMx3EXJx2fkij3yf1UGuaG7RyWc/EqQMWPfjoWBIBRwsnwX1nBWyhEVAQRLiz90EmMkn1QbWlh//phlPqzfza0/FHlesUu2vtbfcEnMnHo4=
Received: from DS0PR10MB6798.namprd10.prod.outlook.com (2603:10b6:8:13c::20)
 by MW5PR10MB5689.namprd10.prod.outlook.com (2603:10b6:303:19a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 15:02:36 +0000
Received: from DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b97b:4c81:c15a:dcfa]) by DS0PR10MB6798.namprd10.prod.outlook.com
 ([fe80::b97b:4c81:c15a:dcfa%5]) with mapi id 15.20.6411.028; Wed, 24 May 2023
 15:02:36 +0000
From: Nick Alcock <nick.alcock@oracle.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Nick Alcock <nick.alcock@oracle.com>,
        Steven Rostedt
 <rostedt@goodmis.org>, <mcgrof@kernel.org>,
        <masahiroy@kernel.org>, <linux-modules@vger.kernel.org>,
        <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <arnd@arndb.de>, <akpm@linux-foundation.org>, <eugene.loh@oracle.com>,
        <kris.van.hees@oracle.com>, <bpf@vger.kernel.org>,
        Jiri Olsa
 <jolsa@redhat.com>
Subject: Re: [PATCH modules-next v10 00/13] kallsyms: reliable
 symbol->address lookup with /proc/kallmodsyms
References: <20221205163157.269335-1-nick.alcock@oracle.com>
	<20230508180653.4791819e@rorschach.local.home>
	<e6662717-61a1-3e3d-5804-66629a1691e2@intel.com>
Emacs: is that a Lisp interpreter in your editor, or are you just happy to
 see me?
Date: Wed, 24 May 2023 16:02:29 +0100
In-Reply-To: <e6662717-61a1-3e3d-5804-66629a1691e2@intel.com> (Alexander
	Lobakin's message of "Fri, 19 May 2023 17:50:35 +0200")
Message-ID: <87wn0xn56i.fsf@esperi.org.uk>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::15) To DS0PR10MB6798.namprd10.prod.outlook.com
 (2603:10b6:8:13c::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6798:EE_|MW5PR10MB5689:EE_
X-MS-Office365-Filtering-Correlation-Id: cbba9f5b-67a0-4b18-082b-08db5c67e894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Pg6FjYUFOe4opA0GRoLF4DRxG2faoqYCoCb0a3JYGMw919bUsxSvV03Mg6T84az6jBRmTtgMI6RWcOmBl6veQ1cJdjp0V8ArelX4PgKvIQpdlsvoEmQeOuHi9RCUz8U88BnfP0dAklelPvimKpKqMBobuRTKgz10IwIgNiXjHGoO54zDRASHOS2JPHcC/1jGHkOI72t0zvtqGiwCV4zVV7HJJfBzv3rj+bfuVH6OdVPRztNC7FYprXMoZqUR6SEW5ObgsKOexHJHyqWmWErsjI+lzLpF7n+OqOJRkUIKkjcZnQ321/w2VeHbGeZsJYpZQ7BwRIoaf8ApMlY5jIXiuyHg8u0ygF3fxb5SKLx9vQjwz/21PjCaXIlg/165PQtX6/8xy/hKGVTL0R+jm5/sYL6SwHKN23tIUhwP1UAHBaPZC5/XAUXm6EddttMwSGG5AmkCFXZ2fi3k4AtxlngSHMPYySYTQhok3VgPWx/H9UE9jukftCt+cwOtR5Rq9cUAvV87kLmqekl1KKLty7Ivc6UiIaps4Mfjsvp3j3x0lUpl17zysvP7So3fDK2Rvo+S
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6798.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(346002)(376002)(136003)(366004)(451199021)(8676002)(5660300002)(7416002)(54906003)(478600001)(6486002)(316002)(41300700001)(8936002)(6666004)(6506007)(6512007)(9686003)(44832011)(6916009)(66476007)(66946007)(4326008)(66556008)(186003)(2906002)(4744005)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eBcJoDpib61fYpi964k4lNHSQGtaTSMMPC89zdSKCjDKbCtwJI2Wj0fHJJQI?=
 =?us-ascii?Q?TtcDaeBHn0UbThcyks3TbMyzvSQbKxNQZNVSoNH4Byv0kafL5RoLdivL4oDv?=
 =?us-ascii?Q?/ZGoGncjtDv3jNEZVxhX9SmcOocDLJjnXuq/IotUjJF3PvFOQ66Oa5JNX+B1?=
 =?us-ascii?Q?5JPbN6czdNkfYKiulvFao37NiV8/48yCvFUnjLfOJw5YnPqp6aBuvvi6e7eC?=
 =?us-ascii?Q?zZtS+edVQ7CJZrd7uPGMHKG4u4s6BPYLbFSnQ4JiAyOxRLcBDlHaUJHb2Q7q?=
 =?us-ascii?Q?5VJzzotmQQ98xwhcz5xfbjqY2QxqlKpdyK1gJghFL49cXrJitR4UuktD3NCD?=
 =?us-ascii?Q?qZOtW8M8KMKGOq3yV2Tn4Na7iB0mfZX51hKgVr0gdX6iFesBytp2O+QU8uds?=
 =?us-ascii?Q?bJ6ba/ASm8kUIQ6WyH3+QdIvYl8AAkeXWtplu2pBIFaXxt3F/O0PRqMOOVRe?=
 =?us-ascii?Q?8J+acDxMYRguta9mJukAcARBzasAG75fEwWeN3+fxHZt7gCYfdPDYHydJToJ?=
 =?us-ascii?Q?RfrNriExQq6bQ4YM0foiISLslmQl7rfcCGjGAgihnZS0iVFk6KRW9q6KDGzV?=
 =?us-ascii?Q?f0oUA9lVCrwO8eF/Ksc0V5UA2eIpEhaXIusxJZ1caDyv7fzTCRAobcwC2O6d?=
 =?us-ascii?Q?saUzUuuC0qu1/avxXhv7r3AEE02asxGKPa4gEhwLEh4IwUU1eME4AkiYxC9r?=
 =?us-ascii?Q?ajZwChGis0HlYPjBn6d3faS7cL/+2ocMZUMIjdo5oAdoXd9UoqKzdPXABylD?=
 =?us-ascii?Q?H/81g4jDPXLIWuidxbsezuhccn4S6Jyy5nF7/QlUej/9bZtwU2DAxZYJNiBm?=
 =?us-ascii?Q?/gHXL0+ILsj/j8AnBtXsjwzZfOUum5RPs4/5cX8+LgsUgmc/TDCFHiC7Qtt5?=
 =?us-ascii?Q?4GQMoNgLUdPGLVC43QbmBPXly3h3QbqXPKafWhc0w24/N5fMNY6ALPWrc6o8?=
 =?us-ascii?Q?bKSjbrZVSXBIxdLfbNo9Lb9XK4F9XIBYMkfsXL5A/Lb0N9GCcUt6fmwY+eb9?=
 =?us-ascii?Q?QfFF2tukCnfQZCmUZ0pdlxe03dZPF/vnGJj2yZe8K8yf3uosBmipGIS7tNB7?=
 =?us-ascii?Q?6xTai9/DygNtGVy2ESYeq1WYVXzQb1pvOAh/nkYBfOqeJYQ6fHPQwHxhCj8H?=
 =?us-ascii?Q?vl3LNFVTw9DiHhrVdlhQsB8qZ0Uz2Crq4Pb4TOarJyaAUJuBn3x8Xd88TtYN?=
 =?us-ascii?Q?PR8TOCedV3X9mqVK0N5w+LFlgVW3yHjSMK9POxBVqGxuof4bmeXb/qoWMPX5?=
 =?us-ascii?Q?nUjJaVAtXZwgZhewOcJyN7roAEHiUQvrrohIH65FE5B0KIlUSNk36Prb4goN?=
 =?us-ascii?Q?Hhptz4esS2OW/d+OPU7WQFVrFSiQLkRO5bppwZIm1AdSh9Hootj+mRRozxAb?=
 =?us-ascii?Q?1QBZovI8tlkh/VVVLPb3SLHGmGTtVE2JvXa/hdqDsv2O0lQBfgFMb8nxUdXR?=
 =?us-ascii?Q?yF1GeLaOWzhn+zdR/HxWLF9kGb2eBm8SZ499vGfKus61xwYZFrV/oNgoqRGe?=
 =?us-ascii?Q?pAF31U0oEUFFB1Go4zV0aAgivUTbUGHd2aUg9FcggfxCoOBvlbQ3aKu+xLgl?=
 =?us-ascii?Q?MyWoesBtEHhHMj3fe4VnJMGvmZ4IxdYvhdnBT4qEtMJKenFcc7lW7thrm2RO?=
 =?us-ascii?Q?Hw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	=?us-ascii?Q?vnt07pRq+c31UAOwlIRJY71HnDROMO/bXPbWWka5MWkRhDRnJNp7jdnNMp5x?=
 =?us-ascii?Q?K9bO8tRGWvgUV6MkN2BOp8n0q9NFXzXuO9frQ794725gtQaC/nSSfTIU9OfY?=
 =?us-ascii?Q?JcKOZ5kmrwkoScpXuyvugr6DysAnv+277YzPB0es2VbHryzZzr86/7/r07pD?=
 =?us-ascii?Q?/JpHBQQ5WziX4n6sfOGL6jVYVOOKKJFKycvUNTcl99AeYeNl9OL+HeSZg7/F?=
 =?us-ascii?Q?8FotfAreWhVYGe6UeK1HgQ6rPG1bFipdqecSEmmhgR3BW4LGtRIr5vtfRj/Q?=
 =?us-ascii?Q?7WFsUraT4tmD+qwDHwhm0d7wK99vaAGnjHRwEJ+WwR2QGMAa+kS7GwISCZYh?=
 =?us-ascii?Q?7u066zS4JazYA0j9HcR/aqyXPcJrKgTloTh9DTnwlvMhWPhySO865M+JMqP+?=
 =?us-ascii?Q?a7dR8QxG+vIgopsU2jJ5n084/n/lN3Itm0ky1i9NALuqgBlhVQ+OszVVF/Mm?=
 =?us-ascii?Q?Ih3chcD5Z5sqS056SjHgN/RrRT3lhGCvaxmMYKXlqlm7IwM3bpCqauEinwJk?=
 =?us-ascii?Q?79jcE44lqdjeloQrauwD/eUzFjcOUBugLpLWgzbmsErEjxrPAPmdr2EXTppT?=
 =?us-ascii?Q?oWvIcaAdncrolmbPJqXLMHqVmrrBVEHmIKbttjlL4JVw7tVweux1ZuTrGmw/?=
 =?us-ascii?Q?7+W4ATYso0hTyC7D1qCpTVbXRq8WG/17yMJzD4pQi+5RojUEuenJE4bvR5qu?=
 =?us-ascii?Q?TWYr+f+EQzW1zgk7rPumHQJ/qes2g1Le7ZCsaTgJc6fX+TSaybFzE4VqNjLW?=
 =?us-ascii?Q?GmM/9EVNGZgnVal0Zc3buU3oNbJvwkglxsqWOig7QdnBAsiR6TkW/Iux40CR?=
 =?us-ascii?Q?nhHbs3vgxmI1cA5Lvo9y00Wn00C1q2Kg/dB9DAlZ37t4LCgeB3tPgrpja1+s?=
 =?us-ascii?Q?kVBtfjfqSLrGeoK/niDI2VDYyCCnsfrka3OMfFkx3LNk8sztTKrB3tsmVwxN?=
 =?us-ascii?Q?nCGztTPMFxepPDMmYNr21A=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cbba9f5b-67a0-4b18-082b-08db5c67e894
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6798.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2023 15:02:35.8983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ofk++aRQJmaMNO77arAASRy1d0XdiyicRiUgJ1ofsMKOLZZf2idQjVrFFyvac6ygQZ4KTZ3HfYB2O593x7S3HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5689
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_10,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=669 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240123
X-Proofpoint-GUID: QV19iAJ07XUTxwsPq2E2V905Xst-y96q
X-Proofpoint-ORIG-GUID: QV19iAJ07XUTxwsPq2E2V905Xst-y96q
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 19 May 2023, Alexander Lobakin outgrape:
> `file name + function name` is not a unique pair: in one of FG-KASLR
> discussions, someone even wrote simple script, which showed around 40
> collisions in the kernel. My approach was to include file path starting
> at the kernel root folder, i.e. `net/core/dev.o:register_netdev`.
> I'm not sure why no comments happened back then tho. Maybe you could
> take a look, I'm pretty busy with other projects, but if you find
> anything useful there in the RFC, I could join to a little bit.

My kallmodsyms patch does much the same, except to save space we
eliminate any leading path elements we can. Keeping those still
necessary to reduce redundancy, and eliminating the TU name entirely if
not necessary, saves several hundred KiB in my measurements and leads to
a total space hit for all of this of only about 12KiB. (Downside:
slightly less clear naming in /proc/kallmodsyms.)

-- 
NULL && (void)


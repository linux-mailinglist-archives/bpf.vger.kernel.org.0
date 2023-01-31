Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08407683A39
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 00:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjAaXKG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 31 Jan 2023 18:10:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjAaXKF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 31 Jan 2023 18:10:05 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0138D4DBE5
        for <bpf@vger.kernel.org>; Tue, 31 Jan 2023 15:10:03 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30VIiAFd004152;
        Tue, 31 Jan 2023 23:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=LpRUsFzAIPG3ZkXND5yaoc2P1xYPLlbtM8jCGcTF2JU=;
 b=zEgHeqRV332N6ML6rr7rUm7y8lhF3Imoc7RBoEVkxbEU7ZH1VRl0CEEi1JPYkCpBFdjN
 za1g5IiOBN6MDF24fcyWn5I6GKyBwHqUJva4VVLLozEFa06b2Jg6rNNHM/mj64bQIalQ
 CEEwFdR1AO2djyHD17xe0P440jCXFEkVnYEbo/5/tt8EylQ12Vc41G87JKJrRr3VwboL
 vx+5e+Dv4umUuWfAoSV5SchaqokIkTQbce33Mf4SoncEjeaXdGDyd1yQzaM0jAWsRfGY
 4YL7VucPjwtJNGOy3tsXZ9SyDUcGrggibw4cC+F0AKGgF/B/D3+/ywiLW3GItlGNIixe kg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ncvmhq01r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:09:46 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30VN8UQ2033834;
        Tue, 31 Jan 2023 23:09:45 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct56ewgr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Jan 2023 23:09:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ceWXyrQTmt80RWSk6oxs0zPhIOVjSioosG26zxPEhJEGB4w9zUVu7rQn53RuSZZWhoHklWvMlAunVDJv8A59PHmROk5IogkL3d7D1quCCnVRsp5uENmt7jtCEOD+EUDgRAUkSd0LOVcIikP60TbZlNObvk7CjVRpzB0bxm06BP1/pqJl1UN4+OZin2hMBF2f7HiflCyykE+0q8tAr2uzkyK9kNWkBzYg1yyDa7DeD/crxckdfDT/nav5Qyj4lVoMSHvx/8PqS0UA3wLtsazDFy32RosLvAVwRH3igroQoXpFUjknQwvyUUvPxlExL+/vLG8LeOr6tlIoQThE1QxA/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LpRUsFzAIPG3ZkXND5yaoc2P1xYPLlbtM8jCGcTF2JU=;
 b=UOtqnHL7fF0knhp52GWXzK/drWQn2Y9hTwx/A99v5WObfdg4+E5jZBjIy9v57zVxkn6mW88UWe476e4FWZPZ3NyfGQdJgis4OXLzFUC391SBu8ZzcGr9cpdFJ3SF4IFy6CiRh/uNIQj0/p2VfW0t2gXJ6zOnERx/m1adhpqa2WqA59P5bGanJMTNGePEESflBumz8q3N1S/5D6wBThvpWs3jHP9VTLwofyLlTGHuJp9/v4Ews//A7u10MhrjHO7WNqoR4IAeC69x++fpvAI8YHQuKf11tzz/rMXqmfutJjcSBfEOVxNypcWpkw7gpDET0wT8+C9PIdGFO8mBmts3oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LpRUsFzAIPG3ZkXND5yaoc2P1xYPLlbtM8jCGcTF2JU=;
 b=wdXiIbNcyxtmLyKi5q7+5KgdzBEc/okIAVBM5no3Fuvp8Z/EJjoPXPEQM4PyJ58BGEZiRVRmQE9D58btWm7J6+DZ4lXApdPIKXrLuJt8n9fnkgxPypNs61KdrSJ5i78Kcznc7sfH/kEM3xIEPgOl1l0XdBSxZtheTpojiLPagAM=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by IA0PR10MB6890.namprd10.prod.outlook.com (2603:10b6:208:432::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.19; Tue, 31 Jan
 2023 23:09:42 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%7]) with mapi id 15.20.6064.019; Tue, 31 Jan 2023
 23:09:42 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     lsf-pc@lists.linuxfoundation.org, ndesaulniers@google.com,
        david.faust@oracle.com, elena.zannoni@oracle.com,
        James Hilliard <james.hilliard1@gmail.com>,
        Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [Lsf-pc] LSF/MM/BPF activity proposal: Compiled BPF
In-Reply-To: <cb0532ae-3500-6caf-7e84-c9ed0763c49d@iogearbox.net> (Daniel
        Borkmann's message of "Tue, 31 Jan 2023 20:52:00 +0100")
References: <87edrbhq3k.fsf@oracle.com>
        <cb0532ae-3500-6caf-7e84-c9ed0763c49d@iogearbox.net>
Date:   Wed, 01 Feb 2023 00:09:34 +0100
Message-ID: <87h6w6cndd.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0346.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::9) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|IA0PR10MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ec61c97-da48-4590-ea95-08db03e03bb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SgdFaCO0vreDH02QFxBXXeARdIoVCBkWfVlfN5KoK2KYN5ytXJGSt0d9duGaugZdQSMOj34mZ43F0vNWurVOsRfSwvxpIw9dapM+rZwSlft6Tr+QcJTiI7FDVqbI7v8uyE57TgBBwpS8PorYDVZiU45DdD5ginXmttsXUrJP/nM39TI8FqgciM8sRNrNUI8RTtkAt+VDe9KD+YCW3GL8ukOo3y1a12ElcrUqCat6VVAO5GqjRbPAvlRg1OBuOKAJABqhzxbmEj9aWbT1+np+pgtSBcEV0gW3NDbpZdrDm98oRpBbE00lQQcKFh3k5cyiaD3gYfDATFEQ0K3ERvAvfRFpvFO5tVODurI4M02EwamNR3G7BiciHpl+PDkv4oDjxyd28xldERDHGX5Q1pMASsdPUsFR81VfYaZrU9fAo9rE5NgWkeKm+cfiFBTat4IP2kFWioQqMXW7AyOeJuuPh8JcMHdVir2Wj/dXPFXYmxnzgltbflzOk/EBwY4E6Y/nbPW+t3o6FLpk2Sw+shoV7lp62U4bqV81CrYKcPxoQ7VrTHVm8r7qoL5C1bFvsMjLP3wel0CkK+16MzaktZhPx5Eiufj0AMoFKG1SMeu0/WOb/K8FQb2OR14ShLyj5F1+Zp/UUWh3nVeW/rE+BRB4JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(376002)(346002)(366004)(396003)(39860400002)(451199018)(6486002)(4326008)(54906003)(83380400001)(316002)(8936002)(6666004)(66556008)(41300700001)(8676002)(2616005)(66476007)(66946007)(6916009)(86362001)(53546011)(478600001)(186003)(6512007)(6506007)(26005)(36756003)(5660300002)(2906002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3iFL8OGxC/oH/iRQiu57tasKo/Mp5xzr2b9S0ev56Dj25sipf0G8Vwe4w1fk?=
 =?us-ascii?Q?szNZG2nMtt9uVYsolU85b0Fxi6EKOF8bHbcm80Ph60rWxV2zHegYu9tgm8Ha?=
 =?us-ascii?Q?CLPlpEkyl1rGJG7ovvYBPnNLHlL0HWdfsXcPKoejGUGJUpE4kLgp732Db6Tw?=
 =?us-ascii?Q?tkc7mTN+9yQQVrx8oiWZTSFsVoB/npPYJlePsw5oRgFAeKjl7z/fS7fQY+sv?=
 =?us-ascii?Q?iWJ06jrqu3XY3jmFbyZ5gU+rDhL5PqLMz5BXblzaAx1f4zlJ1fjrktOlUodu?=
 =?us-ascii?Q?+BiNseEBptLUmLDFIQgKov1RQNQxjknEyX1gbVrB8ZIMQLg6EXBvpiAfvC1E?=
 =?us-ascii?Q?QuX1nHe31XGWEfBzLlk0uXzNAqOH6ulfY0ijEqyxmnjlWshhCVKstkoL3puS?=
 =?us-ascii?Q?hVJgfZ9I0Y174WSLE6wb1rfi5OUfQsHzxnpTbaAFwN0VzlwUaLVdYI+pm0qe?=
 =?us-ascii?Q?y21zpb26s3KUsZc/oy9A0gkeysMvIXRyOOAZJlThy3DcEwn4n8wTafFsi89/?=
 =?us-ascii?Q?2gV5oyhwBCNIIVaI5mIumGfA/xtHBXcWRM80cmpw7546XafKkc1U39JBBKXG?=
 =?us-ascii?Q?SmlntVfQxss+8dOFSAOsKJafS1iyHBUAwUlfYF71Y4MoiJsrPePU2eTnBI0q?=
 =?us-ascii?Q?hPC8NFZFjksZ9m6Z0Rik3/LtahRtI1OEtG7kOAYXKYNQwkhZjGp804Evwwgk?=
 =?us-ascii?Q?OtEC0FqXQz6rrLQXoA45AMoUYD1W3i5S4Pl2VR3GHYw4zArm3yjR4CsHtj9F?=
 =?us-ascii?Q?6Otqjle0ws7fk3NN875uUN2xOEOVrVlhKCbM9ydz5esF6I84HpP3sVee2y0W?=
 =?us-ascii?Q?myb2VeIkv1s39WTrvA3hWgafvPkJsbE3pT8TIFFwQ+sdjiMZPSUXNMiTv0Kn?=
 =?us-ascii?Q?tjvlCsaSGBH9wBeGekJDvOQaP+JCzkYujrZGpLOBPKkOuiuSkPhqY/m50YDn?=
 =?us-ascii?Q?e4W28WOUI6b9vqH3VLsPzGllN9wS4MNE72APITLTLdlVs6yOJlqE86WpOOv4?=
 =?us-ascii?Q?5epwrsCt0j+D2vF0mobe61GPtNFKOmjhy+8SmCUhxRMOYhLhozT8xqOjl8Q2?=
 =?us-ascii?Q?q2/2KjkowchEZDq8uUzu+U3n9rMx4ecIqhvT6nU/X6SwbStrGRpjsVZcws0r?=
 =?us-ascii?Q?RECNylUtPrlbjWdeoF8IxT7R4D55baXVupisp+r89xKMuxyicciGw8ZIj2NS?=
 =?us-ascii?Q?ati0K9QZAH39bpBWSioj8q5zqZfxI/EmXQwtdoIhKIOLVMazmw7NspfmaMOf?=
 =?us-ascii?Q?TcqPMbccBZyS1Zd6aXq2mtaIVrdYu8PS0mImoDFFuXy3fFEFFA7jSHR6+Qa2?=
 =?us-ascii?Q?3KVjq1gBosiM6Fkttj+jDw08ag3k9TNcYnQ8KI1tBvuMN9OXdp+O72vR3Rvg?=
 =?us-ascii?Q?d2bP283nmJsQF8ejJ+UKg7fQ9vuelzcMvd55L6esMnpJkaW5XVjJKt0Kpwo+?=
 =?us-ascii?Q?0Uan4zVwvuUxF82UPT8611xeQT1gVt/xKxxPwxd9LPwBr/4pnohGoVQVOo+8?=
 =?us-ascii?Q?W7t+T3ZkedVNDR2sm5Ar5v4bwLjBhkJB6g3YkQcOr9wm6GYMBB8mnUBJDVe3?=
 =?us-ascii?Q?3/I21agKg0yCqBKZzg8wbaLlH29ohIB6IGg1p4gqAP+UFG8q3EAkDCKM2+2J?=
 =?us-ascii?Q?bw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?3nJ4gDqC5UYkxm+ANiIZRgOEh9+kq4v8KLD8cfQ+0fo8icYeqPt2X2EQ5voE?=
 =?us-ascii?Q?EIV7n7OokAqjHeHkJtXcoGb8629MaO1xeNTIglfkjlCnFfO8c3sW/5NGEms4?=
 =?us-ascii?Q?3B3SIeBsKkhQmzuS6BiSJ8o7Cj08ny6XViq3f7ee2oxr/JW7WrkQf/ARI5+/?=
 =?us-ascii?Q?BQxdJHIJHBwjYfC1EALOU+wRSRy+kkUAdpYrzxjwPgZt++m4klJe+/nILJ73?=
 =?us-ascii?Q?XJbRIc9Izuao1KBVkTGE3iqCVznZi3LTCGRwn7L80kKasE9v7jri+hO8XePu?=
 =?us-ascii?Q?2Uh5YAfTohcwTc2Zw7eArSg8Eg61Fxl1GA4rrW/W6m1OybZPXLBsQuYLoEOX?=
 =?us-ascii?Q?5IiBf06LAIFeQpUfn3hk5ASiAODZuuC1rL/OFeYZDF7/zr1j09zut8CSyAD5?=
 =?us-ascii?Q?gkhrtZentH6JS007KzO1PpSMbqskP34VoMhkG1FgQ4mDs0m1HnIJIt3T4EAT?=
 =?us-ascii?Q?BtcpODKFfdt1Ac3qPRZj1G7NZOVu8Ruc3LlzNhwhVKuG6LtWSN/BiswUPxUz?=
 =?us-ascii?Q?IzYWcBhwidgqd2Wgsni23rnjVkr/fjRZfTy6DlOOc+vtsQk0kS7dbeHrfUBf?=
 =?us-ascii?Q?tXB3APZUHRyV4FH5BMd8CXrVyXdegSXiUIy+c7Pcu1jgMru+YddCwhvYNp8K?=
 =?us-ascii?Q?LBx92CPXQeikZvZvLzAJ0JNpVjQ91HFdTEQC1K1jxsuoslVvH0uQnz/DjXQS?=
 =?us-ascii?Q?NWb4Zbq9r87gXc1R++Zr82ITsGZS6L0KPXasNL/rDURWrU+lTBtfp7DLYmdM?=
 =?us-ascii?Q?4PsZgDmBQhh4NMYl+RlKJXL1N7JKCX/hWE6f1b8/ie+kWGPKuQdodF1P9m/c?=
 =?us-ascii?Q?BBI9NTKDc2HKmOnJ4/bCcF4Uef4LgHclL3wta31b/T8DXMdXDruMpzRSnAqt?=
 =?us-ascii?Q?95a7ozQvQAIj9+YLZE172/QVMRVWsLtGYFoYwm2PHj6jTf6mbd8yL5Whpnb9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ec61c97-da48-4590-ea95-08db03e03bb9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2023 23:09:42.5153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LgRDziQLES5Hzjt1iDEWH5wUTLIB8ick3FqwE0g6mq7Ni3gzE7rdsQLPus0ZX2xpmf/fAqss0LF0qB/hZt2EIhGBN0aKYYJnYaQL9bvUHi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB6890
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-31_08,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=607 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301310199
X-Proofpoint-ORIG-GUID: QYjNU1Vs3cu0ykhspLy_dL8LfHej5kR2
X-Proofpoint-GUID: QYjNU1Vs3cu0ykhspLy_dL8LfHej5kR2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 1/30/23 6:47 PM, Jose E. Marchesi wrote:
>> Hello.
>> We would like to suggest to the LSF/MM/BPF organization to have a
>> working session on "compiled BPF", i.e. on the part of BPF that involves
>> compilers and linkers.  This mainly involves the two mainstream
>> compilers that target BPF: clang and GCC, but other BPF toolchains are
>> slowly appearing (like the Rust compiler) and that makes it even more
>> important to consolidate compiled BPF.
>> Examples of topics to cover are the covergence of the support in
>> both
>> clang/llvm and GCC, several aspects of the ABI that need to be
>> discussed/clarified/decided in order to avoid undefined compiler
>> behavior and divergences, issues related to the BPF standarization, and
>> suggestions on how to lift some of the existing limitations impacting
>> BPF C programs.
>> The goal is to reach agreements about particular things, document
>> the
>> agreements, stick to them, and a clear plan to implement whatever is
>> needed in the respective compilers/tools.
>> Potential participants in case the activity takes place:
>> - Both David Faust (GNU toolchain, BPF port hacker) and myself (GNU
>>    toolchain, BPF port maintainer) are willing to attend the event,
>>    prepare discussion material, organize and participate in the
>>    discussions.
>> - Nick Desaulniers (LLVM maintainer) is also interested in attending
>> and
>>    participating, provided other compromises he has in May don't get in
>>    the way.
>
> Plus Yonghong Song with regards to LLVM BPF backend.

Indeed, it would make very little sense for the whole thing to happen
without him.  I just didn't want to speak for him (I consulted with both
David and Nick before sending the proposal) ;)

>
>> - More? (Please add yourself to this list by replying to this email in
>>    case you are interested.)
>> Would the BPF community and the LSF/MM/BPF organization be
>> interested in
>> having such an activity?
>
> Yes, we can definitely add this to the agenda for the BPF track. This sounds
> very reasonable to me!
>
> Thanks Jose!

Awesome :)
Thanks to you!

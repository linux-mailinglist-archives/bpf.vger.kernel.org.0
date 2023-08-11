Return-Path: <bpf+bounces-7550-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83D377916D
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 16:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DA2F1C21696
	for <lists+bpf@lfdr.de>; Fri, 11 Aug 2023 14:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D788329DFD;
	Fri, 11 Aug 2023 14:10:30 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C4263B1
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 14:10:30 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB55CEA
	for <bpf@vger.kernel.org>; Fri, 11 Aug 2023 07:10:29 -0700 (PDT)
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDW30M015179;
	Fri, 11 Aug 2023 14:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=SeI/Gw2H/8OkYnJprxKgpSe7LzxxwgrC4eI3e6rBYs0=;
 b=JooNpgArRimqmtDwoeGWXp+fW+qIuAlwoMZOMH2xO/W1zkuYEtW2RKxjK5baYlWiZLeu
 EB7/pcbE9ZQynisaSCbG7b+qDDIIiAQc9Dqp5Cu6xWqPvrC+AZszwiaSrTkIAAZ5LQpx
 qrlSkM9Tbrq7ATWFskEXFkmM7R7SoZHkb7kolUwPT1pC7TVEuQ0X3ZbpBKGYUGQpPKyT
 JDqgsTOY8a42FFDkaAhsNPb+9v44dGaZYwSkAIO+H8yW5N+r5jJqyJ6mZ050K9pmrmg8
 Uw1S/HzdSQgaKGcS7KzpIDl5Ko/pwZIGJtg7OfnfbLTnAzE5nn5ez4Mjzh7PcXMKXNaw Cw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3sd8ybh438-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 14:10:14 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37BCe7ps009911;
	Fri, 11 Aug 2023 14:10:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2046.outbound.protection.outlook.com [104.47.66.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s9cvgdb82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Aug 2023 14:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l86S9ne0I9q/dHQppZCr7bKdLp+V/9mzqA14CrRB1Qac3i3KC1WFezh2Hq70yTRREYyiMknbhkhId8kFDEtTyYKYF/16v6hdpA4nCXeTDL3ABPCXSig3OmnMoSGUj2LmgSaR9yLQNhKqXqD0VDukGvsEP534aIKRiiB5uIhWEgZ6/QGYaZD5bkZn0LJ1m8gPqvZT0RBycW8I5wGihz9zQhwFi/kmDNtT6xSqwNOiIeawj1jqGNVcJQh6UUtGTF+7+Cpd7uyoJfXSBxrwxIQKgwT8cTPTyXUw6ixmM9GbPHrY7gbWBcIaAFNaWxltiPfoBY1gVYYTjrKllZ+BOlkgmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SeI/Gw2H/8OkYnJprxKgpSe7LzxxwgrC4eI3e6rBYs0=;
 b=UUyv4+Zmg2vy46+m2FYnlQxrzYQ3nyneviHL8K4CyotPoYUMYjXAc5bJ9vLSrL7zEedi9HrMZ3davBmAHqGSZesxkWpCz/+lLjCn/bbhF19aHoXPvDKSm1NvUTv3EVLuZPjSeLIJBTUEoPCGy+EuJLEWz1Q1nno1tg2Anfx5kLv/h/SepPIN184PeSfzNqIYuQETLp2KrbXVT5K5UKwR9biHnnO0NLw76ZgdHRingiZbO1bUepJpX69YjIjjWbPKyTOY+ZJ6MCReWR8FTi8VHVuE86T6uZEkJpED/g5oo4XmUnlUZDDFO4K8lQTpC56N2d8hHfysdWbkUznCrER8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SeI/Gw2H/8OkYnJprxKgpSe7LzxxwgrC4eI3e6rBYs0=;
 b=IZkDKnwoUCa0cQLVhUWfzP4pokuBrhUN/w1oJXst5ZVUVd2O6HopPyXrnCZR1yBldzbNKr8te35apHYf9raqxQt/JPlzhIt0nLw5aaU2Fc4Ny2CVEgkhY78R4SIR5novsR4IIF02rC2QokU1rBxC2Q5Szt3Nrx6Z5q5T6rkQ1Pg=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by MW4PR10MB6608.namprd10.prod.outlook.com (2603:10b6:303:22e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.26; Fri, 11 Aug
 2023 14:10:11 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::991c:237e:165e:1af%3]) with mapi id 15.20.6652.028; Fri, 11 Aug 2023
 14:10:10 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: yonghong.song@linux.dev, bpf@vger.kernel.org,
        Nick Desaulniers
 <ndesaulniers@google.com>
Subject: Re: Usage of "p" constraint in BPF inline asm
In-Reply-To: <48b24b86e221a9559a13d51df57b72d0da5d0c7f.camel@gmail.com>
	(Eduard Zingerman's message of "Fri, 11 Aug 2023 15:18:41 +0300")
References: <87edkbnq14.fsf@oracle.com>
	<a4c550e4-1d65-aace-d9ba-820b89390f54@linux.dev>
	<87a5uyiyp1.fsf@oracle.com>
	<223ef785-8f8a-14bf-58e4-f9ed02b21482@linux.dev>
	<37b9680f074a871041c3dd61d22e6a6c9fd02fb0.camel@gmail.com>
	<87v8dmhfwg.fsf@oracle.com>
	<7ae83d1248b649a8765a3e01e7a526c86b956ef3.camel@gmail.com>
	<87y1ihg53e.fsf@oracle.com>
	<48b24b86e221a9559a13d51df57b72d0da5d0c7f.camel@gmail.com>
Date: Fri, 11 Aug 2023 16:10:04 +0200
Message-ID: <87sf8pfz5v.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0656.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|MW4PR10MB6608:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb501b8-3412-4908-439c-08db9a74ac95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	DO7aWoaWlV4qUbs9l1fkqttNkpqwa91J+KahN6v+y7pqS+7TsxcykVM8ZF62IFUUV1YHJly1okiJB6SBmR4nJCsVRmdwv1+SxmZ8WlN6RQ8uGG1m3AL50QdLWic2AD/bw0oRILPPfBZLVBfNB922jDHIzemLmItErAwfHSfCwZgR5zsB+qJW4/csFqZk5/GS2FcspfJSVt9pEJxfkl25BmGwBRVQVq8aBae729APBJtSNpBNBdDnLTAtFSiCrvVwrYTTzyDEXt3tEzF5hfHLTb37GDMF0YYT0PBmhQ/c7nDai1KQDcJWNEggwuJc2/eBeQ0zQxrmG4ZbuEIkharANAoJMzczSn+10IOUL1+lpOOl+4tas8oz+jyQ8Ivl9OXKakcilbOVo/hWnuNp3PI/bK0zvLZlB32pAjr7kVnLKqh7dDbMk/tFVYj+iamMU2NFugEm/j/L+l9p5TRbvH/8iNeYlu09b0MpadilchWJmUSN/w48/ecN+SRc5hwfnrUat/mNA1NKkAUIsKvgOs3intndeJtcwGJF426sE6kh4u6mNRhTnG8/yL/MtueyssWN
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(346002)(376002)(136003)(366004)(39860400002)(1800799006)(451199021)(186006)(36756003)(86362001)(8676002)(38100700002)(6506007)(26005)(66946007)(41300700001)(478600001)(66556008)(66476007)(316002)(6916009)(4326008)(2906002)(5660300002)(2616005)(6486002)(6512007)(6666004)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?WzI/1mnQL92G4wynh7R+AhlYwGwKh8YoqJ7DWYI2OUYSya4Udu1F48lC9gGJ?=
 =?us-ascii?Q?89qhPSLsjQu9MFpbJJL3vL4Tf7UF1kFiJXTtoMeCCXchka4nZpjZ3amHstJ5?=
 =?us-ascii?Q?CqEQ4b/I9nYdENr57/a19zSIV5bajV9R+jdUb3vnPWodwdjUKsBjfnPHW2tc?=
 =?us-ascii?Q?UTCXN4M8A2O2/8Pr8pdwy2C53kztDftaXf3zumvSOMu1vA6V+WHT+Dzqx8Tm?=
 =?us-ascii?Q?TarprEGoB698UJRXcV6Arjc3yHzZB2iJ5XGuRD6ZdnszHszxXiHas2vUIkqy?=
 =?us-ascii?Q?EWKYftiW07URDibC5yEAK36choFvWFHsF4OQyDkmN6Ax5LCYQn0xUlb6NVYZ?=
 =?us-ascii?Q?6KKZUWi2cr0rLIjVq55KNWsQPF28026TJmCnv2FcmMpqwiBDSAeNXHepn5Sb?=
 =?us-ascii?Q?11w2nwPFeteI9mgrDmhnJY7ZW7eGaacJuECjZwVPYqe4mfvNOjQg55UwP0+y?=
 =?us-ascii?Q?PYKiFlH/0iV/a5iDNVOXCcMByn+mlGp3rjTqfp2Z3HBL3ikzVNMLzUJC6Rnb?=
 =?us-ascii?Q?80HScAdvTmYu8ToaJU0wGpplerMgiKgXCPPQu8bZ4WLxgUqugYLkOyddGlAE?=
 =?us-ascii?Q?yY6ii0NSX8BqJj3ZNrrDLgMiRl2uoFU6Tf6uEwIkNTrW7Bt3/+eDgV0dkB65?=
 =?us-ascii?Q?af+33VlChAZa35pFGKdokUeDMdxTX2IBRqUgVq1Nz4jyBSANPt/GPMMIvTUa?=
 =?us-ascii?Q?ZmOkyXk18YPpNnSKVznq0dJCfl83tDFl5E+v8vgQI4pxL6NVukdcsf9czS95?=
 =?us-ascii?Q?2IsKVuZHnn5TvJdvndJgrytrMMdtx5hx7B87JbRAaErUMCbu2gWw7OaabNml?=
 =?us-ascii?Q?u3sGhkrRg0ZMiesnmirk3e7GQSp/8U9yhz2OWIijABSxg0XvfmsgE5V+JBLM?=
 =?us-ascii?Q?gAY+acVfl5EBqXx6MEs64aE4wgZzSY5pjHrTV8VhSj0GvFDcB0eaZaXZT9di?=
 =?us-ascii?Q?9ALq1U0uGUwhKrw9j8QwlAiU6X/yiptz3kgtz+IoEB2dedcukLjU1G5lgzpu?=
 =?us-ascii?Q?dqN7VlfTPCJvIRtBsdPNSlXYDKlw4YU6EZAWwb3HRL79WhaccmJmGQyt5omD?=
 =?us-ascii?Q?OTjaGgXtrccpDivboAIRr1FHcyc3muYLAZQRfDojNyryIAfgu34CuQEbCjUf?=
 =?us-ascii?Q?BXVFWWVBsHl/7ApAvyejjp46AYFvsAMWJ7aUTksfXr5NEpF8SZgu0O4SjXV5?=
 =?us-ascii?Q?BsbZu4H156szuQhkzsflkwpLNPR0pi0/XBlv9l1N3QjqabvXgFjHrFelNtRI?=
 =?us-ascii?Q?TDg5i50BlyOf1yKDWerCta+PMohfBOcXZhfkrmAwMBP4c8pTgqP/MaS4+hWZ?=
 =?us-ascii?Q?SL6RVFXFZKXZvXnSuXZPTJKT+cIealm2DlzHdMDkHaxPM5WJV39Q8rlFhsK4?=
 =?us-ascii?Q?ESYBDr1B/aKotgWl1/ue/tZAlKzC6bZKAri5aH3ZrekpprCbDhprmLgpi7g6?=
 =?us-ascii?Q?BeEIwT0K7b5NRzNR5fHmRw24008r9TOkwbv2dx/6pSyFZQnKor8DvrRRlEnN?=
 =?us-ascii?Q?S9k7GYPHRCSNMqx9BTTyb96RGThp34MKoLiJoR/i6LWaGy9SFJgVvlgZckzG?=
 =?us-ascii?Q?m4zXg46JADHW5fBMs04V1OsAr4+OrDR8tg2rM+JssTnQ5eLF3n9cW6l7lrmy?=
 =?us-ascii?Q?Dw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	eUoFxcewYOr0AYukhOkkj6U19rYH0wZydSanlDBOF/tSuBOPk6+DUPFu9lNNgAxYRvtNidcA5MRlM/TFDR55byjYjH+YVHN04YhtwtIQGasQE4rjfqYytFGD9chjv/zJ0jmxqv0ifLnWKjUrh/yHbEneFfuMDArpVkdl0O4WKvBqKQH0a+OIfJnAw1qti+lgWafkzB3LxfL/lcbomjsi4hMdmd8jOBRmXfkqPMjA1p/3aW/VvDRcyUP5tOwzl1BORipJ7YOYNGumxjIvzvhmhOCXBLO0L8aKZi7XqZREtS7y5JRVaPt/h+rJUkw4vJrrlxclh2Nw9wpDxFy8I0TlNfCOflaJsx4vc2h52JSRNIqzohWaLphwczshUvHT5jYWi/YQ0AgZOIypsIQeVbqCo94bDepNlvcwwWSIzHM9tT8V6O1FyP1DzJ0jYqNVWffgvi4rylnjzs7UI9lAq1QEYgRy9MOaMg7j3KULrYXu8KKXMpU8A4+RtYDjVWlOqzNHTlnlq39sHuoG3BSP5W0/Tls00ISMQMCqd04lpkEf56Kr7exRNWyVAnIkoXblXcq0CWp8Ae0dCCM9VQgJLD75f7dkKfy2WWk8JNyDGLOnt31bufTV7Ir0jgmy54AEubD0/RxzbNMsX2opXefM1OrHw/Rq8EiAu8BzRDPLDZ/Fxh50NFWQMUkXguD8luI7jDnnIOeiOCTF/R/3AJ4AQKL1juwS0KEYAda54hDv7jOBG+Dndemj8Qu6Imj33dS455AcWRR6p3leFSkZjfDq6+efR8l6fNI3wpTb8zZTUNOebGRHZSgSg8kePukdcSthiz2IH7pNOK4nV7XDnBKtkgeXiQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb501b8-3412-4908-439c-08db9a74ac95
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 14:10:10.8913
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2Z9qBVWZI92AWLb9dGnUsCN+ZfA7Ww9sC2PQowh/PpYy0loc/RpVsWlU5BK5NF1j8Dnp/u+YAxdg5hzKoTU5m2iNoTunElbXe2fhD3jQUY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6608
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_06,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 adultscore=0
 phishscore=0 mlxscore=0 mlxlogscore=959 spamscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308110129
X-Proofpoint-GUID: wqYJXs12NeRAI23RkVDthiG8lc_RWhHq
X-Proofpoint-ORIG-GUID: wqYJXs12NeRAI23RkVDthiG8lc_RWhHq
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On Fri, 2023-08-11 at 14:01 +0200, Jose E. Marchesi wrote:
>> > On Thu, 2023-08-10 at 21:10 +0200, Jose E. Marchesi wrote:
>> > [...]
>> > > Note the same fix would be needed in the inline asm in
>> > > selftests/bpf/progs/iters.c:iter_err_unsafe_asm_loop.
>> > 
>> > Right, sorry. Tested with that change as well, no changes in the
>> > generated object files for clang. Can't grep "p" anywhere else in
>> > selftests.
>> > 
>> > [...]
>> 
>> Thank you.
>> 
>> Ok, so since people seems to agree to the proposed fix, I will prepare a
>> patch for this.  First I will have to set up a kernel BPF development
>> environment... but I guess it is about time for that ;)
>> 
>> Other than running the kernel selftests, is there any other testing you
>> would recommend to a n00b like me, for changes like this (code
>> generation changes)?
>
> What I do is run same kernel selftests as CI:
> - test_verifier
> - test_progs
> - test_progs-no_alu32
> - test_progs-cpuv4
>
> Do you need any help with the environment itself?
> (I can describe my setup if you need that).

That would be useful yes, thank you.


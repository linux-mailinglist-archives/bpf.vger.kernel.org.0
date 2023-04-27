Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB99D6F09ED
	for <lists+bpf@lfdr.de>; Thu, 27 Apr 2023 18:35:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244108AbjD0Qf2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Apr 2023 12:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243284AbjD0Qf1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Apr 2023 12:35:27 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A070746BE
        for <bpf@vger.kernel.org>; Thu, 27 Apr 2023 09:35:26 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33RFn0qj002556;
        Thu, 27 Apr 2023 16:35:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=s96Eq/nNhlzG3nsRQVxx5cuExfxP081CKBLulXkW1Nc=;
 b=V9tuKj+FmPM4CXf896Ys1p8VSv/8Nz4JicScX0iAnKy2byzAh3MNGJ00vL2B7gxOrdoZ
 8TnMvEoxnmwQ2QvsyR8UjjXBv4ecggxLpBdMtSGzJ7wiAkp6A3ELNXyb925jqYKf/3ir
 r+uemMUcqcf2JKsnDR6rsEMRQ4NTFIN3BKJCPlnoahYmOyvQ7aYb6dDCvChst3w2am8F
 0lI7uKpPA8QwFA+wF7BhGiDL0QlgqwmK9sYw9IAngcvmR04q88NliItk22LcREh5QvM2
 0ku5+WAWnOBZHbE0guxH+sHW0kW9tpgKkykw3UR5HbNGi02sBIp6JTU6GpusimEDFNHi vQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3q484uve03-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 16:35:20 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 33RFTsad007340;
        Thu, 27 Apr 2023 16:35:19 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2043.outbound.protection.outlook.com [104.47.74.43])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3q4619jxw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Apr 2023 16:35:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mD61xr6i7dwby2KOck3+UV4bwYMjjEmt3MO4UhuBjU0+aFT6mbqOM/LKaoap9LpUE27nTiAJhm5rEAXGe+s15LBZ/3Kd5FTpYbpOW2GcWPcLrAV8Q/czzeJwF95CGzIxnusU3ybsxofm0ptgtodUKz/pzOPfr7vKhG5faFwBqi8ux7LqoEwAUUaEval1OOThGsfECtw4YDijG+3FaQUIBAPZHaiJ0fdca/sneWw9u2gyMGVgMCeKUfKfYy/9UU14fSCGVLT7jVQ4DTR+GXKYSz+I8Xh6Y4rVYYLCBITF0dn4aR8P6IGtk/HvY2cU2NUYCBLgvd6ixH0XN3VizD+JxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s96Eq/nNhlzG3nsRQVxx5cuExfxP081CKBLulXkW1Nc=;
 b=OlfO3pLYnB84gM9a1JIvjupgOrrNJlNsBkQlXLqibzzV+nOAQ0/VcyCt9DE6zhWNF/pvCZPe5eButJ08PDNiNOtsB8SfgL10lWzlexFNtjuQtkIZCLPuHRu0xwzOA0tVlLSUpdkK6BB4lreI/gZL54EY3PeEserbzSz0no51NLkA8/+1Q0ajPrZ1N9PN05kdg66quzamI39vv1kL2b31A6G41+GRuSHrpFabdP0K85vi+5VCwthynamMMKSAt3ZS+K6OzjUe4qbEpUDuZCsc/+O2fKDhXPfib7PmDBBsx+eLdY8SEg6GafKfjZ3P3mj4Sl+3/Uatj6VyOMpKoF62XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s96Eq/nNhlzG3nsRQVxx5cuExfxP081CKBLulXkW1Nc=;
 b=rmsDATUma/2aLI57qTZhblToik1LQW4iMIUQ3WRRxJwTkqgoP1Xe2P0FijE30AF5N/Vaj8SjlBU769kBySr7d/I6nDIecOSMnLE5XbNRp4yHwn87d0/ju5S3tsnOPGYnjlEaSctyigYd8DKsr0x8ux+c0xajhvJulnJlxQiiPZA=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS7PR10MB5135.namprd10.prod.outlook.com (2603:10b6:5:38e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6340.22; Thu, 27 Apr
 2023 16:35:17 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d8ec:1377:664:f516%6]) with mapi id 15.20.6340.022; Thu, 27 Apr 2023
 16:35:17 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Eduard Zingerman <eddyz87@gmail.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Yonghong Song <yhs@meta.com>, bpf <bpf@vger.kernel.org>,
        James Hilliard <james.hilliard1@gmail.com>,
        gmartinezq07@gmail.com
Subject: Re: Support for the pseudo-C BPF assembler syntax in GAS
In-Reply-To: <10266b33214afa1aedf90bb61208abf392cfa7ff.camel@gmail.com>
        (Eduard Zingerman's message of "Thu, 27 Apr 2023 18:22:08 +0300")
References: <878reeilxk.fsf@oracle.com>
        <733c57eb-1299-57ae-7aa5-a9dbd51f5559@meta.com>
        <87zg6ufnrr.fsf@oracle.com>
        <CAADnVQ+MNbWCWD14xf50nK-CsAdzQqsnY3x4uSuxO=pNDdmZXA@mail.gmail.com>
        <87o7n98wep.fsf@oracle.com>
        <10266b33214afa1aedf90bb61208abf392cfa7ff.camel@gmail.com>
Date:   Thu, 27 Apr 2023 18:35:09 +0200
Message-ID: <87354l7076.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: LO4P123CA0061.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::12) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS7PR10MB5135:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ef67616-7faf-421b-cdd7-08db473d61b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xZZq/dF2ofeVZsQVtu2a8WH1TpGGGzX3EfqmwnzxNi1MBdKguJz4jp+tS9sP7QblpbKy0fR1YrlwRMPJ7AuTYOmCQlYxXaO7nJYvtxgObisB9tjAf7miyTfQX74kuCHyvmR5MYRwT2DYijT0dqNjjHy/uzUyIW72ZMEDoMqu9MuqtX8202zILCfBbZfrKBypEPQqBw2JCaPHv/DpUJtxbPqN8wy7shiscdlLQXD+Dq0KiJLmOGtIWEBuUUcCub7ue/AH2U1DsEbtB5TNhM/8ZEEnlfelTAXB8eQPw/eQTUUy2Nk54FW9WZOEWZMVUi+NcbSRw4BWULiREXLcYngbTtdhGZ02TOMx8bfUugU7YhS9/hhNbBtYVk8MxmLYioL01LvlATl83Wcy8QbfMjiiOibtW4yXhrpWeItEZv4b7sRcXrmydRQjjzLqG2+iX6pZypZMQ+AiiLw0Yi2uq65dDgejNnUB6CGMVAvest6sMXsfvzVVOiuxEbp0chEFd4q7Bk7CEuohq3C50po3t5wj2ukY18SecPHfVMjrh2dmbpqOOT55MTj73FsKjnwPQARBLs5xUfZPmuzf0jugHxytQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(346002)(366004)(396003)(376002)(451199021)(36756003)(83380400001)(966005)(6916009)(478600001)(2616005)(6486002)(6666004)(6512007)(6506007)(54906003)(26005)(186003)(53546011)(2906002)(38100700002)(4326008)(66556008)(66476007)(66946007)(41300700001)(5660300002)(8936002)(316002)(8676002)(86362001)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clFPN3h4OXQ5L2FLUElzT2t2YW9ZN0c2aEhFQ0tnUjlFNTA1M3RCOWdEbW9O?=
 =?utf-8?B?ZFFiL1IwMjM0c0F3RTNtVUFkUGlSM04yOHBuQjBxWnIzR3grZ0MyejZtODVH?=
 =?utf-8?B?ckRoT0lxanpFTU9haVBwODNrU3YyRStoZitUTkkvMG4yV1pSSHMvQ3hhWmJL?=
 =?utf-8?B?ZGNJWi9yY0FhanAwV05vK0REa2FmSGEwVVl1dDlMRGYrWng2aG9VckdhWU9K?=
 =?utf-8?B?OGZOREhsVHc3djY0bDF5UmorVmMxQ1B4ajN1cDUvQ1l5YjJ3UFA0aklINjZ2?=
 =?utf-8?B?bkJIQ3hLR1hQejhMQTc3Y1VIdTMvSmV1bzBycjhIQlRGWGlHNS9XUDVGMnlw?=
 =?utf-8?B?WnNUWEVXN1BwVEk5NGFjYkpqSzM3WGJucHhaRWEwU25Cc2dCdCt4U1NLbHVE?=
 =?utf-8?B?RGttSWJvMjJrRjFmc1AybjdGVmJVQzM2TUdEMzVPT0E5VVVjRW1ISkpsaU9a?=
 =?utf-8?B?RVEydU9xaVNzZkttZGFIbXBZSFBVdW16UGdZd0RSZEo5ajFWVENhcktGcHJ2?=
 =?utf-8?B?dDM3VTRaOVpJKzV2dWRvWlZxbmZGellhMnNSRGJPZUQzc2V4YzBCZ2Q4dk9q?=
 =?utf-8?B?TldhTUcyM0pBQUtyNjkyTkdyVHpJeXNEMG9sT0JXcTQ3YUpBY3FEemd4Vnow?=
 =?utf-8?B?S0dUc2daQmxpS3piUGdlMW01K2JqT1I5OEFRcDJUZm8venZEbG1NWVNPY2Z5?=
 =?utf-8?B?WUhZa1hBMHY2clhmMDhMZkFpb0ZtcmFtVDZIRTNSS2Fzdk9MMElvcis2OVNt?=
 =?utf-8?B?YzVRZGRENndocUR3aVpFN25CY1hUcTVlMzJQYjdBNDdoUWc5M29OUjJGYkpI?=
 =?utf-8?B?K2pVSDVhemdFaWVMbGNxVytwUVZMVUc3cHlsOHArSkNzS1llelJ5NVVtWklC?=
 =?utf-8?B?aitHdFdnOERwQlpXTWdNcWlCNzJhTUFMR1d6MVdubVIwYk56a2g0czZndzZr?=
 =?utf-8?B?WXowTmcvYktzQUNxUDlNejR5QmpLUGI4dHpuM0gvak00ejV3QW85TkFXWnF3?=
 =?utf-8?B?K05NWlVQNlZPaTBQMWJ2S3JDNG1HQUhCYW5CakxKRlFTTGROUEcvenIwR2ho?=
 =?utf-8?B?RjRDamtZMEhDQzN4TndsOVhSaSs3b1BlVjhxVTZHNEVGa284Q1hIS2VFRDc3?=
 =?utf-8?B?Y0xld3ZXcUw5RkhxYWtPc1JTOVVQaUYwN0NzNVh3VmNKN0JXbzhUeXA1QXJ3?=
 =?utf-8?B?aHBVZ1BKMWgzaHZVM1djcFVhcUJiME5XYmhVV0toZWNlSlhscGR3c1ArUHZQ?=
 =?utf-8?B?OE8va0IyUHZlVlcrTzc5QzNtcHEzTUJDcWtOTml0SDExK1hVQnM5N2pOMW95?=
 =?utf-8?B?QkRUSFE1cVUzL29ndVFFaFJDVWdGY2xEUzFPZG0xZ1NMNy9SOXRLaFBFUVhp?=
 =?utf-8?B?S0crcVk0YzBhcm9FdlhKSkJEbGFiM2NBWjlwclh0V0t5b2V5aWprOG9ERFZK?=
 =?utf-8?B?RkFUNXVIQ3R4TWNrTVdGRVZLV05pemIwSDc3b2xOOXVBalJlTUg4ZDk5NmZP?=
 =?utf-8?B?czlkVFR0elg5VGVkcDVxNy9KZ1JBL1I5dTYrZzE5S3I3c1c0NjdqVUJibm9M?=
 =?utf-8?B?TU44bzJJcjRuU2paWDlmNDhMYTZUemRJNThpS1lqdFU3ek5zM3Jlb21qRno0?=
 =?utf-8?B?Q1Bva3JvZllEbHhrd1VzMUlzNlgvZGxCaElYM1l2MlhCcWx3V0U5NDBjU2lX?=
 =?utf-8?B?VXloMnduczFmYVlpM0hUSG03eXJGVTl0UkhEZjZtT2ppQWJYRURkc2Z3V2Fx?=
 =?utf-8?B?UzJBNDVjKys1MXY1c3kycEtJTkFzcnVPUmR6ZHBHQWt3K0FvN0FkcXVEM1BG?=
 =?utf-8?B?WmRrS3JHTGNXTURNaElsUHp4WSswb09tNnM1RnJ5L2kyTmZxNlM2VHQrNmp0?=
 =?utf-8?B?QUFFMk9BMUN5S2hvRzhEb1B1bnN4Y2sxdXhxSVhiV3gvUTBCTHY3SXZVRjRB?=
 =?utf-8?B?ZXFmdXN4U3ZCcXczZEkrQjhLWklPMHZQQ0k1cEhiV1dUN3BrWlVxSlpXS3lt?=
 =?utf-8?B?QVRCaVFPWCthaVdVZDRseUhBeWl0RTBzRVZra21JczYySE1vNHhqbnhOejBX?=
 =?utf-8?B?OW1xNkxhVUovQVlBYzZ5RVZQQ1RhY2ZGc09RbFE4bS9PT1R6cTZ1RXJ5VjZP?=
 =?utf-8?B?Zyt3ekp4U2I4dmhMdmxBVmFSdFhEN3BpNE9IL2VvT2dnMW1CMDdyMUppeTl0?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: FW6o+fHI9nPet3Dwiudpqih46niKUvgTQ/qnbrTzTAnKpSTxQkl7WhRqKbKAAfJEZyrutJzGnvN7DP1pZdX2HoMjFnaVOplKVN8ctBCiMYWZU/vssZclxf4PS6lji4Q9ST6el6aDqpmxuZiRnNszXEUM7zw5mMSXMge6HdnfKB+mYVTaggJ/QiJo7jH5JpGdNBsqf+6X3EOgVAYIVJeWbiZ81yQ0W/6tEQqA3ZSQp5VTK4JoR4vnwN9HOo2zC8vWnfblGfqvoSxRpxPc5G0PqX4wYVmVEPmZ3M3I/373MflxG93QoWjreSbtbNS/UtRe8K1vmiy+fQhUxt75RY9HDqUxjdLbYgWtD/YRkuzEy6brJS9pcMxTnMwlS17YUi9Z52ocYXVoLitDRuYiDKNZo0THtiGN9GANDwir2/e2PpdrAw4KID93gK1AZpkAbGTK7BHPKEkZlK5Z6nzBzJsEcT6Eo/IgO4b16h34Xh8eOLppMdSHDpBv2+CLbN79ax7D8+PUb5gbgLvi+KsCydwCovCUs7frbKFbB1+BCmb4sxVxXx7nM5JgeYtzcHvHrmWz7kHN5pvycYiZe5XTr3tpJS9VFvJhukp8jvyVXTG0JIkZsmWSZbB1BPz/T5M2ejqLy0Xpy3qtGMJhk9ucF4UuQbtZHNIhv7oJhI2gQE0KT6aG8AGl1elJ6WQL4/asFuoHEfvz6zFD2QB56ODtAZ+uNj9ortOh+ooHAPbvmSoGnJFDpO1r9IdClDPRXV0MIU6lOv8HooqBjweR3O/YAXmQuVWQ6bL4Q4W5cBt7aoHi7AYNuwDlJtKf000tn1W3GvGI
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ef67616-7faf-421b-cdd7-08db473d61b7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2023 16:35:17.3676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gvkyx8Dh2UDRmIAO3sqP9ho2/TEak+KUX12Fwjv37BajrjefujmSW0/4ZPjc+OaGt5TqIiW5neBPUyEbUakvjzLnMUaBfjTxCS+cGc5nrVA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5135
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-27_07,2023-04-27_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2303200000
 definitions=main-2304270145
X-Proofpoint-GUID: JW1W_qh8xwe_mtLPlvnx6WztTGyyeSyD
X-Proofpoint-ORIG-GUID: JW1W_qh8xwe_mtLPlvnx6WztTGyyeSyD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Thu, 2023-04-27 at 12:14 +0200, Jose E. Marchesi wrote:
>> Odd.  I replied to this yesterday, but somehow it wasn't sent.
>>=20
>> > On Wed, Apr 26, 2023 at 12:35=E2=80=AFPM Jose E. Marchesi
>> > <jose.marchesi@oracle.com> wrote:
>> > >=20
>> > >=20
>> > > > On 4/26/23 10:37 AM, Jose E. Marchesi wrote:
>> > > > > Just a heads up, we just committed support for the assembly synt=
ax
>> > > > > used
>> > > > > by clang to the GNU assembler [1].
>> > > >=20
>> > > > Thanks! Do you which gcc release is expected to contain these chan=
ges?
>> > >=20
>> > > This is the assembler, i.e. binutils.
>> > > We don't need to update the compiler.
>> > >=20
>> > > > > Salud!
>> > > > > [1] https://sourceware.org/pipermail/binutils/2023-April/127222.=
html
>> >=20
>> > This is awesome!
>> > We recently converted tens of thousands of lines of bpf asm from macro=
s
>> > to inline asm in C.
>> > See tools/testing/selftests/bpf/progs/verifier_*.c
>> > I wonder how gas-bpf can deal with that.
>>=20
>> Inline assembly shall work.
>
> There is also an LLVM testcase [1] where most of the instructions are cov=
ered,
> but you probably have something similar.

Yes we have extensive instruction testing in the assembler.

> Just of the curiosity, is the state machine generated by some tool or
> is it "pen and paper" exercise?

It is the later :)

But I plan to turn that function into a recursive-descend, for
maintainability.

> [1] https://github.com/llvm/llvm-project/blob/main/llvm/test/CodeGen/BPF/=
assembler-disassembler.s
>
>>=20
>> > We had to fix several inline asm issues in clang to get to this point
>> > and probably more to come.
>>=20
>> We will give these tests a try and fix problems as we find them :)
>>=20
>> We actually came with some ambiguities, undefined stuff, and other
>> issues with the syntax while doing the implementation.  We hope to
>> discuss some of that during the LSF/MM/BPF next week, so we can
>> consolidate the language in both toolchains.
>>=20
>> Speaking of which, we are preparing the material for the "compiled BPF"
>> activity during LSF/MM/BPF.  I think the BPF track hasn't been scheduled
>> yet, but how much time will we have to discuss about the topic?

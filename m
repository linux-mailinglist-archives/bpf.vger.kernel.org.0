Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54A269E86D
	for <lists+bpf@lfdr.de>; Tue, 21 Feb 2023 20:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjBUTjJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Feb 2023 14:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjBUTjI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 21 Feb 2023 14:39:08 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC420D06
        for <bpf@vger.kernel.org>; Tue, 21 Feb 2023 11:39:06 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31LGhhHt019770;
        Tue, 21 Feb 2023 19:38:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=EQbVq00CjkI7tX1CWaTfcksj4pTQooBdmfKB4t3/Y3k=;
 b=gHCU+rE411hKoFelGkA1n1S3pzJ/Ex/RPCPHCPLj+GsemjjVL1/1YDoFMAz4JMy2INkK
 vPHENvE6diKwiEbX5kheVxzMdXJ7jmk2aKKEBj9dLAArNDu7j2SfuBl2pwQCOAr0Gbvu
 F+UknfOkqgcl6QmAupBXpKeeAGd9v2nYVjvX2ewbtCi5A87dWMcSk1O6znYDJ5NTRuS0
 sXU+xaa0egcLoAP3hp7j6U6CmvI6OXVp3T/paq/+S2IbNTLfe26RJuYkL3HAkJZt7H+Z
 xeCF/yewUTOq10ndWbxE2MnhwA3la6PuOlxwssV3rMDhoCtRtgVCiGnBM7ePFgsUpQhF eQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ntn3dp546-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 19:38:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31LILuuV006926;
        Tue, 21 Feb 2023 19:38:58 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ntn4c4nu9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 19:38:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OZGGucA/RPeIZb1WtADm9m7E8Ep6ocRa2vcR2Z7grgCYYVdjmAsx4nncFcYvVRNmILef1/1+/+cSA/3wGY7hukgWu+/PDiQ5N9Yt7MVbYctETiueIn0Ip2JpHRtfro8c9ym19Tr/K1zpBMAVkpGm8e0qDX6d0i6PiG6yDJoQfK9Ww1Q7OvOyaWNbsC3KpRtWgUcqbl9+e/1amc5iKvHXAAFilTgDs1k+r9Czplu5fZANLzJ8LDDXxPJYwi6H2GoCXcNVw4AM4dOJCIImxMP3GUPcdvCDVtNZqMXQ1u45U0rZOZQAD/KkANwp4YPT92xNYGgcwgX9jzs03ugi/j5cFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EQbVq00CjkI7tX1CWaTfcksj4pTQooBdmfKB4t3/Y3k=;
 b=OV0+rYfkFVPAS+NCdew+Caccj4p+/tXS6bz4rstxSai1ssysCCOsWrNCq0vJ7Df065+pwJcKjxBeEMW3g5/rqYUHmGcv8JDHkwzDjcNXORbLNwCLf8YRRfrhVVDeeylzhhgVGg2lnK4mqs4eN/Xuf2gmN4RD3/3E/RZKLQOCJnVHVYSe9M3l8cr19SynhdU+T2rHJ0DYlA8HVMjlOQ9QHbidlDMAIGkBv6mZPYF+FwlxVyO8JruL0muibfG0GnRFSQZxyIGCzXWutL1O/oftR6dC4iZ/Pi2y8AhTivQCq77IzH3FuWDgtqLFP/Ch8SFNJwu1rI3+ftTJOCNdtdJD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EQbVq00CjkI7tX1CWaTfcksj4pTQooBdmfKB4t3/Y3k=;
 b=AoLBFCF7kBr7kQ6msGo/XfO/OYfEn5hdF+feA8wxeUpuVcAPkLe9GkhrIypESWwER8svX/iFctPTspWgg2WkyQCQYfcxTaMOEDLbi29ueFGzkJ/7+acTR2aum2n+6SlccACzJoCDHAUI78F0c6ngxKag9GPeDv0hltWGHbBV1Ao=
Received: from MN2PR10MB3213.namprd10.prod.outlook.com (2603:10b6:208:131::33)
 by SA1PR10MB5758.namprd10.prod.outlook.com (2603:10b6:806:23f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.16; Tue, 21 Feb
 2023 19:38:56 +0000
Received: from MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::2248:8d21:35b7:f269]) by MN2PR10MB3213.namprd10.prod.outlook.com
 ([fe80::2248:8d21:35b7:f269%5]) with mapi id 15.20.6134.017; Tue, 21 Feb 2023
 19:38:56 +0000
Message-ID: <1fe666d0-aab1-5b6f-8264-57ff282b5e52@oracle.com>
Date:   Tue, 21 Feb 2023 11:38:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: BTF tag support in DWARF (notes for today's BPF Office Hours)
To:     Eduard Zingerman <eddyz87@gmail.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>, bpf@vger.kernel.org
Cc:     James Hilliard <james.hilliard1@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Malcolm <dmalcolm@redhat.com>,
        Julia Lawall <julia.lawall@inria.fr>, elena.zannoni@oracle.com,
        acme@redhat.com, Yonghong Song <yhs@fb.com>,
        Mykola Lysenko <mykolal@fb.com>
References: <87r0w9jjoq.fsf@oracle.com> <877cy0j0kt.fsf@oracle.com>
 <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
Content-Language: en-US
From:   David Faust <david.faust@oracle.com>
In-Reply-To: <e783fb7cdfb7bfd40e723c67daab7c5f81d12fbf.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR13CA0125.namprd13.prod.outlook.com
 (2603:10b6:806:27::10) To MN2PR10MB3213.namprd10.prod.outlook.com
 (2603:10b6:208:131::33)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB3213:EE_|SA1PR10MB5758:EE_
X-MS-Office365-Filtering-Correlation-Id: 39365383-a80c-45c1-9cd6-08db144344de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wqgRsNp27xGmCaLLAGYQo1yO3CzeMxffoIG1bJwi6sPsWRLXPbqF9HgVAheiNXUtqnmgluKed7jC0vdlfHvRhfxV5Mo0NWm+K9VryyjL/0ycUI4TOFxUGDP6ZUHNYLxdVxhVv/oDga+DPf+vxJOmAbPMJBD1m/J1G+C8TpOpyJRJx2BjyiKStwFm3YZSF9a6D1OH7Z+xrT/GGolCRzLjZ4rWLZ1GxhDp05hu8Sb2LVLj5etRdX8/w2hGzVtBs3CI0e/n6lOdDO2q6VxJ5A4xKvIm/bFKMk3vG82KxipdekdHuetgwhZjGnhYNDEmoW+dEbKg/6bcA0ldk6DX2g0bmuaWleJygnCpYcaS4ne5QQDF2YVmmIQOAfmzb4kR1bLfVKdy3VaHBSqRbV5O6bdyL+C51kYxsQ6bZcIBd3w06FFzEqAd2Knx2w+cv4cx00K7aU4gKDwwinzpTWioIjjp9GArAjPftJyCeNk9FXZojaaUvf1TXo+JIsToaCOmQ1YxJkJgeslcYx2Na44A3SmnBVIjrR4HhWM1BbqcrVSOJ3l8JIvclvmjBIKUtVKm/sFhA6xXuaMNshew0UFZFMekHXX+spLGa5sEzd1SOFBqUAiL57qYzvsdo5GTTAKsvC763tzJEZG6v2oFNE7NW3y5OV/vIKJRJSKR2zqLHXkfKUwHs5gV9zVNdLGXf2b0KVDz7nYBhbXwb36r0eJdeHWCG4mzqVJgDVtQrpwQ/3GxmGDTprhbARwbx80hCiYM/Ru4sVjZ70rTzLf3luOC0sxIkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB3213.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199018)(38100700002)(31696002)(31686004)(83380400001)(2616005)(86362001)(54906003)(316002)(110136005)(4326008)(5660300002)(8676002)(478600001)(966005)(8936002)(36756003)(41300700001)(44832011)(66556008)(66476007)(66946007)(53546011)(6486002)(2906002)(6506007)(6512007)(6666004)(26005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blhnRENQd0Z0QWhTYkR2dUZSTy9CcUFNSGpIY09ZdkwvVW9iRXJYTlVUU0M5?=
 =?utf-8?B?ZnNmVHJSUXZ1RStjZ0l6Z0NEcDQ3bk1MMkZva2N3a3NERU12ZXdhNk1YeW5l?=
 =?utf-8?B?Z2ZNeVpCUVNORmdudFd2TXJMdW9uOFRLb2RnS1JwejczdDRXRnJNZHNZZHk2?=
 =?utf-8?B?TjByejJjZFFsc3ZyaHVETm5HQm56YjhJK1VBNTQ3U3NHeldrTWVPVmxZYm5T?=
 =?utf-8?B?bWxWTGxYR2o0U3dPVkpybG84a2VXYk10YVpTOXVsU29uek9qUmlteHFSUU5x?=
 =?utf-8?B?bzI1RWdPYmRmL2hrR1VDRGplbEt2eWc2WFpxTDlIdHlIbWt1UXZJcHRKWndQ?=
 =?utf-8?B?aDRzQTRtRll2V1Y2a2Z0bzVDaTVrQ1A2amFLYlJNVTJ0REsvd05jUHlDaWJV?=
 =?utf-8?B?VnB6bEJDcVNQNC9acWFoNVhXRWExL2NseWY2SEtnM2lVbC8zUG9hV3hPMnhj?=
 =?utf-8?B?SHFuQTFrM05FNnJEYzVxSENKUC9MdG9ZUVhIaUErR0Y4SnMvNVNKZTl6cDR1?=
 =?utf-8?B?NGhnZ1NRSm9acklrSGJOemJEdTA2S3ducVFlWGFZdERoK0x2Q3JFc215dmVC?=
 =?utf-8?B?ZFl0d3hqUEtGYlB4SmVYSFlzTW93YklJTVdhN0xXWEpxWFd0MFFhSXBIaTVa?=
 =?utf-8?B?SlR1V2t6WjY2WDhiQTlwRUIwWWVENnRGZSsvc2FJbkhuRWpCZFhkMEg5V0Iw?=
 =?utf-8?B?VG5uNUNPLzcrR1pnT2pMWkdoTmhkUFdvRVcra2YvN21YUmJiSUFEZmtpMHdZ?=
 =?utf-8?B?aWp4RTBZSXlQT1NxdkZvRXBHS3Myd0p2Rklmb05Xa1dsUk5GeFZYUjZPMHoy?=
 =?utf-8?B?QlVIQ1ArMks0Nkx3ZEE5S2hKOUpJR3lTbVNrTE9lbjBWOWhnMkczUGpmbGlZ?=
 =?utf-8?B?ZGs0R3RmZlJhZVhoaDdZQ0J3WkYrMjNtWWdVMU5naEJvZTJ4VEN4WnR4ZVBj?=
 =?utf-8?B?Umc3N2xsS0FlNitrK25sVE1iVUM5TjRNZkwvYk1oYlMxcll4YjlkY2ZYWERw?=
 =?utf-8?B?bTE1VURlVDczZ212U2hLWHErZnBlRTcxQ0tDUFlLWHFheTcrY0pSMEduSzVj?=
 =?utf-8?B?bmpvYk05aVgyanI4WlMrOFVXTndOaExRdTNnRWIyazBnRWpRUnI0NnQrT2I5?=
 =?utf-8?B?V3JLc29nZDZoejl1dm5QVGZlU21LRFZkTHZiM2hkOTRxOFY5MHpObWNMM2Z2?=
 =?utf-8?B?UldBZy9ySDA5UHE0UnNweTh3bWVBaCsrVTdhbDVCak5aSHRFU3ZSUEtJZE9F?=
 =?utf-8?B?eXN6YmlSVWh5M09qZWFVMXdPSUFpUndycy9IcnZmWUZETG8zbGdNM2NyTGtG?=
 =?utf-8?B?NjBIbmpINmdLeWIxdkdoT1dkZWVHblBTU0x5WDVLeW1qVDRlQm8xTG1JOGpU?=
 =?utf-8?B?QzlHZFd1ZEszNDZvcTFXbXNLVGN1cmZHSXFNTFdKWTZWQitpSlNKQzJGUGVU?=
 =?utf-8?B?SmdYaVRobzc1QS9qUHcrQjdwbkEySHBUWGlHQjYyVGlONFhHWnY4amh2ZzhR?=
 =?utf-8?B?MEZzQUsvSHhOTkUvaGhTYzA2RlNiZ1Q3eWVWVUpGU1o5MjNoRjBDb3pFd0hi?=
 =?utf-8?B?bS9janZnWXRkK3VyVUsvWkk0M2dJMXBhdUJmd2MzNExGckZ2UXpRQmpvSFMw?=
 =?utf-8?B?aU5tNFVDVEVOWnpnZHQ0WFVhQlgrYVMvV0V4OHI2Sy9pTFFOalByQXVLQzZk?=
 =?utf-8?B?YXlaL0N4MXBHOTBnSHNPOS9UYVRUei9SZXkxL2J0UVMwTWdaaXo1MVRna3ZJ?=
 =?utf-8?B?elBxak92VTRQTGt1ekJlc2tVamhBckpITyt4WC9QQjV6SFpsT1k4eEVJdE9Q?=
 =?utf-8?B?bFU5M1hPVEdGQkJzUVBrSlhBcDBDOGpKdUVPR0ZZbGg4OGhSTSs2YTBldCtU?=
 =?utf-8?B?aGg4TWNTQlgrZ1d5bEVFQllxTk1wckZOYVJqc29NdU4wWENQd3dzd3crZHRR?=
 =?utf-8?B?RDd2NDYrQXpJMm1sYi9qN2t0UUtFd1FFbHJoSGQ1N2VNcmMrNGZZVmNib3d3?=
 =?utf-8?B?SmJpV2xsTFpwMzJhZ1dDZUZ5NEhsRlh1MVFkc2txRTc1d2dDeVJRWkpsOHRm?=
 =?utf-8?B?b1luMHlMQlZMK2hrSkVoVmRUM1M3N2FtU0xPWVR1SFpPdktHMm8yQ0ZQZ1p2?=
 =?utf-8?Q?XvTRJ3F528s4RXdHsWSaJ3N7I?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: n5iFAvcLi0WKCRSUTslclpJsIUlHpByScnj72UutqxlAsMKtc1Rq5C4Z2ydZtdultgW4XX+TRX8Jj0x626YnDim6vxYcSWcRJ/vmDPx9LFMfOewEU7a4tEMBeQ8zyZL+y82ieud4U9BY97Ci6NynukFy/rNskiE/7a0FARI8SoMJpDNgxqyM+C/vYad9G05XjYFUuTgoJ2DYbAykb8wgedcXqIP4qGGtOafYX4jiFXJUxtEPR0zlwh57q0acu+Vs6L+/jWrvhrbQp46Z8REVvZw/pE/+6+1Gv+EbxYH72w0Bf3lE1VDRvkF9X6+2A+YWs5SimeTDhaLgNdNYk1AJe0IbftAY6BfbSyRLV1KloHXDjrR4kPBzyKAkLkhFEdB3d4wiqN17ONGahwvwE3qtzWddrwrJtHOYJ81ErKDH37C+LK6uATay0fhddjnPqZgG9fOhKtvSdMT+lygzZ7/sI73c4ky9KkdBHLAshQ63tQvlQHRtGpX4Hm9833kJ+gc2BwdKQet0uojNjHHNsBv+oXNIrsGQFOlV54qzM74oqPQqOxHyW01wjtUhwnMGrfnc/9jDiXU0Uw7dTEJEHHnvgQtN0x2Hsrmlk5FS1VTiTxVL2o6ArsNRrB8K9QnsEgBPDOH0rVz4frV4C4OlV/127NHsVaSME3VcREUbqNLlmEiVTpGwfkIzuBcu5Q5wsKA680KLCoFHsZvsNBkpBBkNiUCNEhYnQ/yNL0VdcfEeR2+CkzOh+NbvmlbMXCZbOAjJ/l33LM9Qdi8j3RJTz+EcXuW7sKbx5+YvYvOCYRaPx7FYbi2/vNQcKBNKz8WUY2oYBMfwobQgi5FcuvkvJKKcoC60ycZRdIRleH9MoOq3kG+IEWrCQKWHl/LGwK/Gj8PR5FQVeqKD70MK79DeDfx+Tw==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39365383-a80c-45c1-9cd6-08db144344de
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB3213.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 19:38:55.9329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tqsT/at5wSJMFwV7cWVGrhXF1dOR3WbCm3wagHLJ8opDktS9SXKGsScExu4+0HpHfZ9sjgMRfuCSo9/UD+FtdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5758
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_12,2023-02-20_02,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302210169
X-Proofpoint-GUID: ASogmXeOgVAtuRJZdJJztDysMGbzfeIS
X-Proofpoint-ORIG-GUID: ASogmXeOgVAtuRJZdJJztDysMGbzfeIS
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/20/23 15:42, Eduard Zingerman wrote:
> On Thu, 2023-01-05 at 19:30 +0100, Jose E. Marchesi wrote:
>> We agreed in the meeting to implement Solution 2 below in both GCC and
>> clang.
>>
>> The DW_TAG_LLVM_annotation DIE number will be changed in order to make
>> it possible for pahole to handle the current tags.  The number of the
>> new tag will be shared by both GCC and clang.
>>
>> Thanks everyone for the feedback.
>>
> [...]
> 
> Hi Jose, David,

Hi Eduard,

> 
> Recently I've been working on implementation of the agreed btf_type_tag
> encoding scheme for clang [1] and pahole [2]. While working on this, I came
> to a conclusion that instead of introducing new DWARF tag (0x6001) we can
> reuse the same tag (0x6000), but have a different DW_AT_name field:
> "btf_type_tag:v2" instead of "btf_type_tag".
> 
> For example, the following C code:
> 
>     struct st {
>       int __attribute__((btf_type_tag("a"))) a;
>     } g;
> 
> Produces the following DWARF when [1] is used:
> 
> 0x00000029:   DW_TAG_structure_type
>                 DW_AT_name      ("st")
>                 ...
> 
> 0x0000002e:     DW_TAG_member
>                   DW_AT_name    ("a")
>                   DW_AT_type    (0x00000038 "int")
>                 ...
> 
> 0x00000038:   DW_TAG_base_type
>                 DW_AT_name      ("int")
>                 ...
> 
> 0x0000003c:     DW_TAG_LLVM_annotation
>                   DW_AT_name    ("btf_type_tag:v2")
>                   DW_AT_const_value     ("a")
> 
> I think that this is a tad better than abandoning 0x6000 tag because of
> two reasons:
> - tag numbers are a limited resource;
> - might simplify discussion with upstream.
> 
> (It also makes some implementation details a bit simpler, but this is not
>  very significant).
> 
> What do you think?

Very nice.
Keeping the 0x6000 tag and instead changing the name sounds good to us.

From the GCC side, support for BTF tags will be new either way but
conserving DWARF tag numbers is a good idea.

> 
> Both [1] and [2] are in a workable state, but [2] lacks support for
> subroutine types and "void *" for now. If you are onboard with this change
> I'll proceed with finalizing [1] and [2]. (Also, ":v2" suffix might be not
> the best, I'm open to naming suggestions).

As for the name, I am not sure the ":v2" suffix is a good idea.

If we need a new name anyway, this could be a good opportunity to use
something more generic. The annotation DIEs, especially with the new
format, could be more widely useful than exclusively for producing BTF.

For example, some other tool may want to process these same user
annotations which are now recorded in DWARF, but may not involve BPF/BTF
at all. Tying "btf" into the name seems to unnecessarily discourage
those use cases.

What do you think about something like "debug_type_tag" or 
"debug_type_annotation" (and a similar update for the decl tags)?
The translation into BTF records would be the same, but the DWARF info
would stand on its own without being tied to BTF.

(Naming is a bit tricky since terms like 'tag' are already in use by
DWARF, e.g. "type tag" in the context of DWARF DIEs makes me think of
DW_TAG_xxxx_type...)

As far as I understand, early proposals for the tags were more generic
but the LLVM reviewers wished for something more specific due to the
relatively limited use of the tags at the time. Now that the tags and
their DWARF format have matured I think a good case can be made to
make these generic. We'd be happy to help push for such change.

> 
> As a somewhat orthogonal question, would it be possible for you to use the
> same 0x6000 tag on GCC side? I looked at master branch of [3] but can't
> find any mentions of btf_type_tag.

Yes, we plan to use the same 0x6000 in GCC. Support for btf_type_tag isn't
committed in master yet; I originally worked on patches [1] last spring but
they were not committed due to some of the issues we've now worked out
(notably the attribute ordering/association problem). But 0x6000 is not
currently in use in GCC and didn't come up as a problem for those patches,
so I don't think it should be an issue.

I plan to submit a new set of patches soon, I will add you in CC in case
this or similar issues come up in the discussion.

Thanks
David

[1] https://gcc.gnu.org/pipermail/gcc-patches/2022-May/593936.html

> 
> Thanks,
> Eduard
> 
> [1] https://reviews.llvm.org/D143967
> [2] https://github.com/eddyz87/dwarves/tree/btf-type-tag-v2
> [3] git://gcc.gnu.org/git/gcc.git

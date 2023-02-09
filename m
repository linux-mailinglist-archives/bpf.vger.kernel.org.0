Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BCA9690985
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 14:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBINH6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 08:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBINH5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 08:07:57 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8747E04F
        for <bpf@vger.kernel.org>; Thu,  9 Feb 2023 05:07:55 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 319BOjS4003011;
        Thu, 9 Feb 2023 13:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=GZADrPhHaAUhg2RvGnGkq2YOrwPd23cVo4S9oXpHcpw=;
 b=ayk8cVkqepmSKNZ/u9YQ6682vYBIz0EhawfvKgseSKPi9QczEj5V/cj3Aaar6g8eQmZ9
 ghtIrvtqJV+O9fVpXFKUUzAjTCkUKOaUJsnunUySvsUA5Ogg1zeK7wSb2VUaFpH5Of9N
 w+iWNTPsbajWikO3xI9irT3Jq6XbrEzQMKYMd+772okv3YNnNhDrWoq8Xr1CgKGKSLvd
 zZW3Bzo6rTOq7bTle5tPCzKDD841JeWKcdazDiSFjoMqTZicWUwE5rXJm6dlkor4weTK
 L8WXFmIXXPSWk4zvLq08zMUt9bzpbQZ3d673MBoNd92HmDgCxSdtF0qu56FQa/lYVpIf qA== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhf8aamq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 13:07:45 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 319BfmGU015234;
        Thu, 9 Feb 2023 13:07:45 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3njrbd9jwy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Feb 2023 13:07:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm/1h6nTYrQ0Zc7io5AKVh6UGOY/RzmtDNIDrWpcn5/eezclOeVRzJKFfxeAzXPr2hxABdLuLRsmDNBdtvLN17U/SSKp9Jofol5NVwrvEmUHz4KjIBsN4QDiE1Ps15Wz/qz8BtEtRfrIqvCiHLslI28J2X1dKczlLpqyOlRYVF3YX1Vtd1UrwWkWKcAuQ/9FEkLglSbWZ3Tv+eDnbVl9hnSfj7gDkZLi+BMTC+LooscHXYCWJvcouosnl9vFi5het8on79Z8GK+Yv2VsCTTg6qzwdiwuiOjFx3qkNqKzCJtdE9sIqWvYaiat3TKyGrjpJLQhgCgsg66LMoMpzwnqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GZADrPhHaAUhg2RvGnGkq2YOrwPd23cVo4S9oXpHcpw=;
 b=nMmxKS+QX2UXBlqQnurRr5twYPu6WMdd6RrpCa/KaKNUHlNCRCWwNxeEUsnWyVU2c1wFM2JlH5njQlcQHgpQdUX2kLdy7RdHfUj1voonJgnACKFctnliDhDepJ9MzEiR1MxES7GTepjdNI66RAqeh3VML2semLv1ouW26ncTomvET/2DTh3t9dSv/V7MFgIYe14df9cK110heZoGOt6w75AR8MSW9YBPom14iQ6/pGOt1WVB6LTN6Gu3u+IoKaskBhAE8ofJffgc7juHBA+cdrmOuYnmBlGU+NhU6j8F2zP6bihqWpXcUNIgaaH5AS8w/nMAx0oJ196SvUYJBE+rNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GZADrPhHaAUhg2RvGnGkq2YOrwPd23cVo4S9oXpHcpw=;
 b=nz1fSjvlcow0gBikZPIN1ZwxyjUQmrZhnRo6O4ZXQRsfhGc2kivUbsjMkwB/bO/VjI/relxeawILXH6xnzfWGVwDzAlCjvMjcBTGU2anTozlHRZ2BKKCkTCm3t5Otvb1UyCWXWlno3FSsNCBFrIjMf0TIA8cOpRTokrksSmCTA4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by SA2PR10MB4651.namprd10.prod.outlook.com (2603:10b6:806:11e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Thu, 9 Feb
 2023 13:07:42 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6086.017; Thu, 9 Feb 2023
 13:07:42 +0000
Subject: Re: Kernel build fail with 'btf_encoder__encode: btf__dedup failed!'
To:     Alexandre Peixoto Ferreira <alexandref75@gmail.com>,
        Jiri Olsa <olsajiri@gmail.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
References: <57830c30-cd77-40cf-9cd1-3bb608aa602e@app.fastmail.com>
 <Y85AHdWw/l8d1Gsp@krava>
 <0fbad67e-c359-47c3-8c10-faa003e6519f@app.fastmail.com>
 <bb569967-d33a-7252-964b-a36501b3366a@gmail.com> <Y9RlpyV5JPz/hk1K@krava>
 <883a3b03-a596-8279-1278-bc622114aab5@gmail.com> <Y9kxUzyfpEQpnN7w@krava>
 <d880b3b3-d6fb-c891-bfc2-9c05c321ddac@gmail.com>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <0474fbe7-14a3-71bc-02ed-73ad44b4b2a2@oracle.com>
Date:   Thu, 9 Feb 2023 13:07:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <d880b3b3-d6fb-c891-bfc2-9c05c321ddac@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR01CA0155.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|SA2PR10MB4651:EE_
X-MS-Office365-Filtering-Correlation-Id: 639b0714-aea0-4425-06a0-08db0a9ea083
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IJZGTm8KAXbDWojP7vqxpmfi7/RKsNCbhYqa1zG7FDp5wIAXi7DFTH21y5Va2/KvdoecN22iEz4ffdSw/Gc6yX3VuMSEVe5yG9ZiA19jYGw9/jOoD+I2M+zdk5Yvbi7A7RFGXIiRx1fC/U8agWG0uZH54a3eplZBoml2o9PqjuPo3wKRlIH1oI9vRH+Phe2Rp1zZsN3JwO0RWo3widKLgLi4S3+fbmQB0gpLzWaM/gemcdW+YLS7GpKcmeItqmsFN1oa1Hr8L5RGNCjBDaGSTydKDPWz/2n8pmApe0e6e9ztYWZhjFk/1bNoPARRjqkv1+ny2cY5gwWFwdRheroj08BcL+A/OBaPWe9P2nh+tp2JIe1oFOBKVl2m4o2CE9MNFR2pHx3KkUpUEIrzimVEuRZLBxXWDhz39g6sM88Wst7G8ufxDuDtLZRzBPWMREV9hhErbEeHsAu7V25xROl9AA+cSSTZpvxqo+SIu3IpxT5tM12FQ09u8lXAZ9sxxcIgp4AOLyJ3MBGkYGZ1xlUZxlUajQUGmliwUqryGr0/WCUCgTumvJWLLyb2vfc1Bo9Dzk7e3oaPK7f5pFrNfDdutSiKenHKDX3cZohW5Yv0KYaFf797GccC5bH2/n4vvoOw5tVuwuOc008CKaqs0NhvfZQKtr1DGhYTmihf0ccaLwUGZ3tLD24DVaBdtyD/c3EPDspTLaWXGQxQyiW9b/J6bMkBRdNXbMjgoIpZFQr2a4rd+WHqC74L7x3PAz7NzdniuPLptMHCXWw2MatRgs1uWA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(136003)(39860400002)(366004)(396003)(346002)(376002)(451199018)(36756003)(86362001)(31696002)(316002)(83380400001)(110136005)(54906003)(53546011)(6506007)(6666004)(2616005)(6512007)(186003)(478600001)(6486002)(31686004)(966005)(44832011)(5660300002)(30864003)(38100700002)(2906002)(66476007)(41300700001)(66556008)(66946007)(8676002)(4326008)(8936002)(101420200003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OXk1RlRueUQyVUpqSzI3R2cwM2VpSGJGeDVpT1RwL3ZIcFIzREJFcU14YjFm?=
 =?utf-8?B?UnVvYitON0xETmw3QVBIRnVCM1BUYkp0N1M2VXQvcGM2U2tlK0lRdVNSbzB6?=
 =?utf-8?B?RE0ybHZVdmNWL05CZkNuTEsyWnh1OTJYNHJQaGdLTXo4NDIrZGhDVjZYbWJa?=
 =?utf-8?B?dmg3a090ZDVqSExsSEFmWnpBT0lEMUZxR0ZNZUZ5K3ZqRElkcEJrVy80RzhN?=
 =?utf-8?B?emNZUUdIMzk2ankxZHl2akNGazRSbVBkU1VLblM5VE1QclN3NWE5M0tpNS9q?=
 =?utf-8?B?SW55N1hGdThaNjh6UjVHK2hjSjRIQ2FFdmwzbS9GTnFkcnVyUWJSUU9pdHU2?=
 =?utf-8?B?RUtEL2VpZXpRcHhwUXU4RzRMMk1SdnZkVmd4RE50dVYxQ2pTWXFwZG5yZE0y?=
 =?utf-8?B?bmFWZzFVank1b1E4RXE0WEdoV21sQjhvejJtbzRKUC9tOTJpYUdpRHA0MHIx?=
 =?utf-8?B?bUJjcytIcFlnZWp1dDkvRHlUSjc0a3JUQkx2R3lTSUVNMlZoVmtqYnhFRGdS?=
 =?utf-8?B?VE5wQXhDLzdkbDk3NTE3YndEWjhVbUcxOGV4RDZ1c2xiZ3dFcCtUSUlNVE5m?=
 =?utf-8?B?bVN0ZUNjY0dTMkZLYXZnOC9UbDRpeTZEN1llU3U5ZHJkejdxQWt6SUpQOVE4?=
 =?utf-8?B?UzZSNWdTUkpwdnFuOWtSZlJWb0QzRFRkVWRseklESHVUUVpENU8wT3FQd1Ja?=
 =?utf-8?B?N3lWSG9xV2pNL2Qwc0JrV1RlYWpzMHhIRzdyVnU3V3lWOForN0dtWnhxYjdY?=
 =?utf-8?B?T3Bza1gwdXR1N1lRaE94dG0xb01iY0RMWHJ4ajZPQldCVlVkTmJGRW4zeGl3?=
 =?utf-8?B?eXZHT3pUblJSRGx1dGRWbnVBZk50Qm1ZUURCVTNERGovcE01d0I1ZTNNYkp5?=
 =?utf-8?B?bHhLVGlmSXE3U0lXbk9vSjNxeXM2UEZ2UWtpTjVURkovYWptZFpITUl3RkJM?=
 =?utf-8?B?bHpJaWNQSlhSbUJHc01tQjhVUTBoeDA1NG9nMSt3THFEbWtoMGxLMDd2OG54?=
 =?utf-8?B?U0xkREdUdmZ4UFdqSmlxVG5CTDV4TFU4NmZCeWM3cFNNdVQvaDB6NDJHRmE0?=
 =?utf-8?B?dWtLMGlWc05aWll4QlE0NVBkZ0RTTE1KWGMzSEJLS29GTVdVTGx0WmRQamhh?=
 =?utf-8?B?aFh5QWlpdVc0eitERjFLTkNMSldUaVg2ZEhBQTl6bGlVODZPVEtlNEVsdmNV?=
 =?utf-8?B?dy83TXQzdmc5ZzFUQ1ovTG9XT3BtV2FUd2pUQ2R4bDVTRWYyRWdJbFh2b3kz?=
 =?utf-8?B?ano5blFNV2Q2Q2JzWHJqUmlnQTVEYkkwY1ZFL2w5d0JHWEplTXFYUXZaZjcz?=
 =?utf-8?B?ZUFtM2JlQWRRRlkwT053ckRXRnhXTDlRSlIxSWJmcVZDVC9ZM1FtTzlTS2p3?=
 =?utf-8?B?cE1JZ2Z0YXhRVHE1bVRYSG1CaGxyUHN4dXpyVldteTdjUG9jNkdydEtkNU54?=
 =?utf-8?B?aHRCVGZKMjlkVnJUeW5VeXFXMDJBMHg2SWhjQ0p6YjdBOFZwMFAzbEtrU2lR?=
 =?utf-8?B?R1lvZGk0dFZVTUFHUEliVzVDWGdSTlVUZ3dHS3Nqcm1ja1BIVHdGUThtYmUx?=
 =?utf-8?B?SHlGWHNpV0V2VUtQU004OERYVU5nMldocVdHNnNwdVovRUlOUisxM24za3hB?=
 =?utf-8?B?Ymw3Vk9vY24xbWE4WEFzZUNZM3RPOE1RVXEwUGJwMlpoME12Z2VJdmp4WVQ4?=
 =?utf-8?B?dG5JdXRnLzNTQURoT1pWVm11SDQyV3RUa3I4ZDVVdVFlMHZGVStwdTJER0lY?=
 =?utf-8?B?NFFyVVU1VDdLRlZsVlI4Y2JxU3c1eU10Um1DNEtRVVNIVS9JQVhWV3BtT3Bt?=
 =?utf-8?B?S3VUUFdZTUZRTVRLWkZQU2luNnpuMmhpTHIvYlpwQXVQV2dtVEJkMmp1YzZx?=
 =?utf-8?B?OFNIUGo0eTM0WjZsbm1tL3pCNVFQSFJKWEZoR0lvQTEyMVpOMlBDai9HdmlJ?=
 =?utf-8?B?S3Mrcm4yN2E5SVF0NFRDSWY0SGllQXdyaDM2SzdjdjNVcjIwLzlscWVZd0pK?=
 =?utf-8?B?N1UxSkxNa3V2V2ZhV1hRcUdmZGMwUStScGZDOXJNa1NSc3k4UVZzR3BieEhn?=
 =?utf-8?B?QWxEelFtRVRSNVRmR2k1T2FtaFBybGwzdFNkeEVsZnJmUWZEZVFoQTkwY2pI?=
 =?utf-8?B?YnpOaFZzNkpCSmpPVG5uS08zSzNsWERxdzZFS09DUmZJOWJ0dUVDUmEyQ1Zu?=
 =?utf-8?Q?pcvsxgOBaI09SWUS1iri0WE=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZRKU7IKProw/jUTDSshp+1H5PwfZH2sjMLI5Jeq2/mHH1KfyMds3oztCgVGfvRZmC5th0+fIwlxjFfiumK+oQZgHoYjGeI1bWLVkwKhqxqcscTSYFNQ6Q+nMNbujbDYAEBQ7xo0T3Z4LvgJ8OUIb3XJLv0AVgbtyGSHL9ikXyDWh0HuXCYXUF6cVFyLm+ORV6ErSTiDip3Djwi8COHkiELKPCsh/d6UE98kIaetlrn+eU1BChQI1JAb+xQ4RKds3yw3tv9dHhAdprDrX6EPGKsQGdJJjkJKpJWLsbZ27Gi2IEsGvPzARo1y3M5ZFSRGMG+TiTHQAz6Z32v0KNxYd4zFRk5uY56Mukx4owFZPiQb88Y8K0iOw70hIKGeXDHWcnqUWSv0kQ1iVMrqTJzeWVfV1Gfb8mAz+FraYDw5kTwhLjkmdfJ55oSI0/e5kdO9ilZgO5L2eWIh5jbw/gLbJjcX1EtHzxKTtvyIutSrWdzQz8FSv6MD/0G/LE5FQsh4Y9MPvWZhPSFyzCprRZqNj2GbL8zagjzaK30K9X9y3iJ9CULBSHnRl9EWOJnXVOnHuJn8p23Of6t0+/WUzm3NTTZfcJHN3lVkBupEhvq+Kpd7e0mlUXU3lfLYCi1E1yeEYO08ijhsQs/Xdo7u36MkMBUrztOPyeSxQy9ctGj9+FbxFFAJxv8t7N6wr8zOquXJ/B/VNJbXgGHrKnqU6lQwC1rUbSPb0X4BWO7gIypU/324JmCSvtGntzF8KuLy8DumOesuUkFaZFafboYLpI48fdDqVn1sTw8gwxWXMpXFcNI1sitSnEajBoVyRt+dhoLQtO/YS2ogT+gsXbfZAe9M6tA==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 639b0714-aea0-4425-06a0-08db0a9ea083
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 13:07:42.2733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BjRbC54ANuDOHw3I2rZ06Zjh5+g8wFrpoWuTsscY8Mk1+NOyFEU31l8Wa+kD71+NWQm/YjwgcmDFbIDjCdwD/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4651
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-09_10,2023-02-09_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302090125
X-Proofpoint-ORIG-GUID: 2dH0-2hUL4XnQn_9khDbhdtve9IztomL
X-Proofpoint-GUID: 2dH0-2hUL4XnQn_9khDbhdtve9IztomL
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 09/02/2023 04:15, Alexandre Peixoto Ferreira wrote:
> Jiri,
> 
> On 1/31/23 09:18, Jiri Olsa wrote:
>> On Sat, Jan 28, 2023 at 01:23:25PM -0600, Alexandre Peixoto Ferreira wrote:
>>> Jirka and Daniel,
>>>
>>> On 1/27/23 18:00, Jiri Olsa wrote:
>>>> On Fri, Jan 27, 2023 at 04:28:54PM -0600, Alexandre Peixoto Ferreira wrote:
>>>>> On 1/24/23 00:13, Daniel Xu wrote:
>>>>>> Hi Jiri,
>>>>>>
>>>>>> On Mon, Jan 23, 2023, at 1:06 AM, Jiri Olsa wrote:
>>>>>>> On Sun, Jan 22, 2023 at 10:48:44AM -0700, Daniel Xu wrote:
>>>>>>>> Hi,
>>>>>>>>
>>>>>>>> I'm getting the following error during build:
>>>>>>>>
>>>>>>>>            $ ./tools/testing/selftests/bpf/vmtest.sh -j30
>>>>>>>>            [...]
>>>>>>>>              BTF     .btf.vmlinux.bin.o
>>>>>>>>            btf_encoder__encode: btf__dedup failed!
>>>>>>>>            Failed to encode BTF
>>>>>>>>              LD      .tmp_vmlinux.kallsyms1
>>>>>>>>              NM      .tmp_vmlinux.kallsyms1.syms
>>>>>>>>              KSYMS   .tmp_vmlinux.kallsyms1.S
>>>>>>>>              AS      .tmp_vmlinux.kallsyms1.S
>>>>>>>>              LD      .tmp_vmlinux.kallsyms2
>>>>>>>>              NM      .tmp_vmlinux.kallsyms2.syms
>>>>>>>>              KSYMS   .tmp_vmlinux.kallsyms2.S
>>>>>>>>              AS      .tmp_vmlinux.kallsyms2.S
>>>>>>>>              LD      .tmp_vmlinux.kallsyms3
>>>>>>>>              NM      .tmp_vmlinux.kallsyms3.syms
>>>>>>>>              KSYMS   .tmp_vmlinux.kallsyms3.S
>>>>>>>>              AS      .tmp_vmlinux.kallsyms3.S
>>>>>>>>              LD      vmlinux
>>>>>>>>              BTFIDS  vmlinux
>>>>>>>>            FAILED: load BTF from vmlinux: No such file or directory
>>>>>>>>            make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>>>>>>>            make[1]: *** Deleting file 'vmlinux'
>>>>>>>>            make: *** [Makefile:1264: vmlinux] Error 2
>>>>>>>>
>>>>>>>> This happens on both bpf-next/master (84150795a49) and 6.2-rc5
>>>>>>>> (2241ab53cb).
>>>>>>>>
>>>>>>>> I've also tried arch linux pahole 1:1.24+r29+g02d67c5-1 as well as
>>>>>>>> upstream pahole on master (02d67c5176) and upstream pahole on
>>>>>>>> next (2ca56f4c6f659).
>>>>>>>>
>>>>>>>> Of the above 6 combinations, I think I've tried all of them (maybe
>>>>>>>> missing 1 or 2).
>>>>>>>>
>>>>>>>> Looks like GCC got updated recently on my machine, so perhaps
>>>>>>>> it's related?
>>>>>>>>
>>>>>>>>            CONFIG_CC_VERSION_TEXT="gcc (GCC) 12.2.1 20230111"
>>>>>>>>
>>>>>>>> I'll try some debugging, but just wanted to report it first.
>>>>>>> hi,
>>>>>>> I can't reproduce that.. can you reproduce it outside vmtest.sh?
>>>>>>>
>>>>>>> there will be lot of output with patch below, but could contain
>>>>>>> some more error output
>>>>>> Thanks for the hints. Doing a regular build outside of vmtest.sh
>>>>>> seems to work ok. So maybe it's a difference in the build config.
>>>>>>
>>>>>> I'll put a little more time into debugging to see if it goes anywhere.
>>>>>> But I'll have to get back to the regularly scheduled programming
>>>>>> soon.
>>>>> 6.2-rc5 compiles correctly when CONFIG_X86_KERNEL_IBT is commented but fails
>>>>> in pahole when CONFIG_X86_KERNEL_IBT is set.
>>>> could you plese attach your config and the build error?
>>>> I can't reproduce that
>>>>
>>>> thanks,
>>>> jirka
>>> My working .config is available at https://pastebin.pl/view/bef3765c
>>> change CONFIG_X86_KERNEL_IBT to y to get the error.
>>>
>>> The error is similar to Daniel's and is shown below:
>>>
>>>    LD      .tmp_vmlinux.btf
>>>    BTF     .btf.vmlinux.bin.o
>>> btf_encoder__encode: btf__dedup failed!
>>> Failed to encode BTF
>>>    LD      .tmp_vmlinux.kallsyms1
>>>    NM      .tmp_vmlinux.kallsyms1.syms
>>>    KSYMS   .tmp_vmlinux.kallsyms1.S
>>>    AS      .tmp_vmlinux.kallsyms1.S
>>>    LD      .tmp_vmlinux.kallsyms2
>>>    NM      .tmp_vmlinux.kallsyms2.syms
>>>    KSYMS   .tmp_vmlinux.kallsyms2.S
>>>    AS      .tmp_vmlinux.kallsyms2.S
>>>    LD      .tmp_vmlinux.kallsyms3
>>>    NM      .tmp_vmlinux.kallsyms3.syms
>>>    KSYMS   .tmp_vmlinux.kallsyms3.S
>>>    AS      .tmp_vmlinux.kallsyms3.S
>>>    LD      vmlinux
>>>    BTFIDS  vmlinux
>>> FAILED: load BTF from vmlinux: No such file or directory
>>> make[1]: *** [scripts/Makefile.vmlinux:35: vmlinux] Error 255
>>> make[1]: *** Deleting file 'vmlinux'
>>> make: *** [Makefile:1264: vmlinux] Error 2
>> I can't reproduce that.. I tried with gcc versions:
>>
>>    gcc (GCC) 13.0.1 20230117 (Red Hat 13.0.1-0)
>>    gcc (GCC) 12.2.1 20221121 (Red Hat 12.2.1-4)
>>
>> I haven't found fedora setup with 12.2.1 20230111 yet
>>
>> I tried alsa with latest pahole master branch
>>
>> were you guys able to get any more verbose output
>> that I suggested earlier?
>>
>> jirka
> 
> I compiled with and without IBT using the -V on pahole (LLVM_OBJCOPY=objcopy pahole -V -J --btf_gen_floats -j .tmp_vmlinux.btf) and the outfiles are a little too big (540MB). The error happens with this CONST type pointing to itself. That does not happen with the IBT option removed.
> 
> $ grep  -n "CONST (anon) type_id" /tmp/with_IBT  | more
> 346:[2] CONST (anon) type_id=2
> 349:[5] CONST (anon) type_id=5
> 351:[7] CONST (anon) type_id=7
> 356:[12] CONST (anon) type_id=12
> 363:[19] CONST (anon) type_id=19
> 373:[29] CONST (anon) type_id=29
> 375:[31] CONST (anon) type_id=31
> 409:[63] CONST (anon) type_id=63
> 444:[89] CONST (anon) type_id=0
> 472:[97] CONST (anon) type_id=97
> 616:[129] CONST (anon) type_id=129
> 652:[131] CONST (anon) type_id=131
> 1319:[234] CONST (anon) type_id=234
> 1372:[246] CONST (anon) type_id=246
> ....
> 
> $diff -ru with_IBT without_IBT
> --- with_IBT 2023-01-31 09:39:24.915912735 -0600
> +++ without_IBT 2023-01-31 09:46:23.456005278 -0600
> @@ -340,346 +340,14800 @@
>  Found per-CPU symbol 'cpu_tlbstate_shared' at address 0x2c040
>  Found per-CPU symbol 'mce_poll_banks' at address 0x1ad20
>  Found 341 per-CPU variables!
> -Found 61470 functions!
> +Found 61462 functions!
> +File .tmp_vmlinux.btf:
> +[1] FUNC_PROTO (anon) return=0 args=(void)
> +[2] FUNC verify_cpu type_id=1
> +[3] FUNC_PROTO (anon) return=0 args=(void)
> +[4] FUNC sev_verify_cbit type_id=3
> +search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> +Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> +Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
> +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> +Found per-CPU symbol 'last_nmi_rip' at address 0x1a018
> +Found per-CPU symbol 'nmi_stats' at address 0x1a030
> +Found per-CPU symbol 'swallow_nmi' at address 0x1a020
> +Found per-CPU symbol 'nmi_state' at address 0x1a010
> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> +Found per-CPU symbol 'nmi_cr2' at address 0x1a008
> +Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> +Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> +Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
> +Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
> ...
> 
> And the lines 342-365 of the with_IBT result:
>      342 Found 341 per-CPU variables!
>      343 Found 61470 functions!
>      344 File .tmp_vmlinux.btf:
>      345 [1] INT long unsigned int size=8 nr_bits=64 encoding=(none)
>      346 [2] CONST (anon) type_id=2
>      347 [3] PTR (anon) type_id=6
>      348 [4] INT char size=1 nr_bits=8 encoding=(none)
>      349 [5] CONST (anon) type_id=5
>      350 [6] INT unsigned int size=4 nr_bits=32 encoding=(none)
>      351 [7] CONST (anon) type_id=7
>      352 [8] TYPEDEF __s8 type_id=10
>      353 [9] INT signed char size=1 nr_bits=8 encoding=SIGNED
>      354 [10] TYPEDEF __u8 type_id=12
>      355 [11] INT unsigned char size=1 nr_bits=8 encoding=(none)
>      356 [12] CONST (anon) type_id=12
>      357 [13] TYPEDEF __s16 type_id=15
>      358 [14] INT short int size=2 nr_bits=16 encoding=SIGNED
>      359 [15] TYPEDEF __u16 type_id=17
>      360 [16] INT short unsigned int size=2 nr_bits=16 encoding=(none)
>      361 [17] TYPEDEF __s32 type_id=19
>      362 [18] INT int size=4 nr_bits=32 encoding=SIGNED
>      363 [19] CONST (anon) type_id=19
>      364 [20] TYPEDEF __u32 type_id=7
>      365 [21] TYPEDEF __s64 type_id=23
> 
> lines 342-362 of without_IBT
> 
>      342 Found 341 per-CPU variables!
>      343 Found 61462 functions!
>      344 File .tmp_vmlinux.btf:
>      345 [1] FUNC_PROTO (anon) return=0 args=(void)
>      346 [2] FUNC verify_cpu type_id=1
>      347 [3] FUNC_PROTO (anon) return=0 args=(void)
>      348 [4] FUNC sev_verify_cbit type_id=3
>      349 search cu 'arch/x86/kernel/head_64.S' for percpu global variables.
>      350 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>      351 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>      352 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
>      353 Found per-CPU symbol 'cpu_kick_mask' at address 0x19f78
>      354 Found per-CPU symbol 'cpu_tsc_khz' at address 0x19f88
>      355 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>      356 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>      357 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>      358 Found per-CPU symbol 'perf_nmi_tstamp' at address 0x19f70
>      359 Found per-CPU symbol 'current_tsc_ratio' at address 0x19fa0
>      360 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>      361 Found per-CPU symbol 'cpu_loops_per_jiffy' at address 0x18a08
>      362 Found per-CPU symbol 'kvm_running_vcpu' at address 0x19f80
> 
> If the full debug files are useful or a target grep or diff is better let me know.
>

I managed to reproduce this too with IBT enabled; one thing I
noticed is with pahole built with an up-to-date libbpf and the
changes in https://github.com/acmel/dwarves/tree/next, the problem
went away. I didn't have time to root-cause it yet however.

Not sure if you're in a position to do this, but if you can,
would you mind building pahole from 

https://github.com/acmel/dwarves/tree/next

...and re-testing to see if that helps? Thanks!

Alan
 
> Thanks,
> 

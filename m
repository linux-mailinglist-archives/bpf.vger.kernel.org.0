Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EEA56CBCD
	for <lists+bpf@lfdr.de>; Sun, 10 Jul 2022 00:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbiGIWlt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Jul 2022 18:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiGIWls (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Jul 2022 18:41:48 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1998711C37
        for <bpf@vger.kernel.org>; Sat,  9 Jul 2022 15:41:46 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 269D4GIL001357;
        Sat, 9 Jul 2022 22:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=M9Vr43qaLAOtu6RVJL6TgIJ8JGHdHF9uV9Z/z4R7DGo=;
 b=IO3akVAaimhPpf1F0vBCCJtChxszMk6Z7XE8mefa0uel0+JyCsALixCvlbvFNFrh54CA
 Wye8MpcZplbug+/G7B2eszpP3lGKF2tFyUc8mz4MxXu5yWG7vOg27rhgv1Qc+so9XmH+
 szOmIOapZNKTmkFEnIXkvvXQtKU+1LZHwIH3h5bbp7aFw32+GBmzdQWN9zKCd0HIzuaR
 EbdZCk4FWfqCmR5tjbUPK5wh43fUGgiyZavTCKgA/dQjImLbpv5r58pL7EbwdKWOK1ln
 k8iYwH0hifKxErQjuCmzOlMT+mFrv6hzrPbd6Zw+NIFf2+tz/mIYeY3J+N3VDhQm1xvg hw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71rfrtey-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jul 2022 22:41:44 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 269MeSlW013437;
        Sat, 9 Jul 2022 22:41:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7040e3f8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 09 Jul 2022 22:41:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yu38VGHWqbrz1O1UWBXC9nrHh09bfKhtH/blkFLerb1zHM4ITwXpcq4K08yhq2pnDen6LDqV4F+ufdhcQBmRJYj+XCEW7zPzYZ6aWqr9T3FkzdQp7QTIdImDzA10jme62/zdIs4Mhwy0V05gCJREtVkqa+1F3lvC1MXxszzMEnUw7b82V8EPrZnvJpVPS1s/Pkaj3DRrPtm/bsXsNQVd1f4omZM0UjKfhuTGGZxN1geoCrN5WOIf5oigsMwp4WMcAw/atHLW6Fs42/7SPrWdcnBZl00kcg4/itTsuGjmuDqOqM5bV3eZ1zjRBFPRD3vTanSM9FECHeXXqMLGmsUhvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M9Vr43qaLAOtu6RVJL6TgIJ8JGHdHF9uV9Z/z4R7DGo=;
 b=hxX9S8egyyYwwhXoParq9a8L1ojJf9fyi3QAwSKYZBvV0ybGFp4qT12X3IYdxSEcB18Ki/eebl70SV0NuLRA7yrrhnWBC3gi6SH8X8K/QtHHzpbPpYArd8/MX51MmS4gyIzHV7o+XbQlYYVpikZwwpdYSn58Bzxj08sGbvLVpYWvtWcIXn7Ij40tqp1jmWKlCBoNFBK4z/T1tbm1hKbnw8ceFO9Y6nK713wJ5D0qVuqY1qmpw4/Eqk/a0RxdejLchNuX+r5e0/v3INoa0+CBhhnSQyZl4VH60sOOrj2EUPI9+8p86iJvwkANCwtWpGdIk5FjElueVgHfzLq302FtrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M9Vr43qaLAOtu6RVJL6TgIJ8JGHdHF9uV9Z/z4R7DGo=;
 b=Wx8xjVJg9sJHZHcDb8jfbkzfyQpuHNp2AOEJjXy2qPxUMnyi7++WU5MBamXf8xZUIzd4nLujk2WsnNMlZ+YCMtwls9yCjr0PoOrqLabSt2YiUuv/8uYM7o/86LcQIu4ifVFj2xPIHRkMKJVGRslqf0uEvYJ/v53+Oojaq5ByfT4=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BN6PR10MB1793.namprd10.prod.outlook.com (2603:10b6:404:103::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Sat, 9 Jul
 2022 22:41:40 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::b5ee:262a:b151:2fdd%4]) with mapi id 15.20.5417.025; Sat, 9 Jul 2022
 22:41:39 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        bpf <bpf@vger.kernel.org>, david.faust@oracle.com
Subject: Re: bpftool gen object doesn't handle GCC built BPF ELF files
References: <CADvTj4rytB_RDemr4CXO08waaEJGXRC6kt2y_SO0SKN3FgWg0g@mail.gmail.com>
        <CAEf4BzZVq2VZg=S2xZinfth2-f50zxhMm-fPVQGUoeYPC5J4XA@mail.gmail.com>
        <87wncnd5dd.fsf@oracle.com> <8735fbcv3x.fsf@oracle.com>
        <CADvTj4rBCEC_AFgszcMrgKMXfrBKzktABYy=dTH1F1Z7MxmcTw@mail.gmail.com>
        <87v8s65hdc.fsf@oracle.com>
        <CADvTj4qniQWNFw4aYpsxV5chdj5v+cLfajRXYOHiK_GOn9OLWQ@mail.gmail.com>
        <8735fa3unq.fsf@oracle.com>
        <CADvTj4r+1QB2Cg7L9R-fzqs_HA3kdiiQ_4WHvj+h_DvuxoM5kw@mail.gmail.com>
        <CADvTj4pFQmS6XHpHCVO8jt-8ZRdTd--uny-n9vA0+vm4xUoLzQ@mail.gmail.com>
Date:   Sun, 10 Jul 2022 00:41:31 +0200
In-Reply-To: <CADvTj4pFQmS6XHpHCVO8jt-8ZRdTd--uny-n9vA0+vm4xUoLzQ@mail.gmail.com>
        (James Hilliard's message of "Sat, 9 Jul 2022 14:39:31 -0600")
Message-ID: <87tu7p3o4k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0081.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1f::11) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a31c86f-42b2-4b0c-26c3-08da61fc301d
X-MS-TrafficTypeDiagnostic: BN6PR10MB1793:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gCT5kjzdkbJHFsFybH/xEgb5LsaVGcO4ut8BfJbUZyMtqU3sY4a1RkuKoLUfIpbwlwH2qFc4tZNgR46hVmLQ/jBjajBB0UW3aMB2ZYIT6hfzkWG7j82FxDDTovupERy04WraAdc+Pmli7ic3D3O18sN1/4O5FxOK3+gDaNYlHctenJ7H1HaOavWW7Kh0FS0GgWN0Xr0JSPTgKOKXkdKSaKHM7mFc7z7ExmRSwuD4aaCN3UQCRBfG9ZDbBibSvw7fQGtFEmYvNe2dA87x3FDHHludQ4/UJRcxd1yeo/BPWcpVnu6wwBs3R9MdnCVu4NwvV6kcaw15p9nNfi40b0S+asdtlTjIzbcFtoDI/vAKIUQ5pSU8ku42W2dFlcq3wUkBh+rwQmdMpNovaeCEz9IyiHH94BLIOGeKnVFqYfW2cuOW750OKeZXcI+Zaa+5Pqalg9bkAHSlHDskvKj1qYkzqx/cZ2c3GMaJGNBkQKbf9f4lrHSm5wlpyNiGSGUfC5SJFHlI8lG1uwPaxbl2Me5nd8RyI13JoHkYGuWQvwNjlVGanA2n4zCpDMVoJF1T0LLQyuht6EXttAWSzsn2wg8L/CYDQFRHfhLGaxdqYUaDSR5b4LqEO2u4io57Fy/24W/ndRftje5cErZEFof1GUaOAmCXA8Sz+z3hNWERHf86GBFIevksklmW+DbgLTv/Xx7ZVIYV/+nqmSnJBFS6wBi6DDNcLXPdsaQNh4OpQMPq6l32AyA9J1/QGlkNmRUfDgp6Ai0CBeEIVzzMmdvnZP8VMLB2CgjxXTCBcNsiZWSZnEyPQ2M0d3Eif+rMcwhE5ttzM/HI1MZ27xa7nx/FOFQC1+xFamOoiYUUUMVZoANbx2s+HhfMVjnk4viTa6Lfg8AK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39860400002)(346002)(376002)(396003)(136003)(54906003)(6506007)(316002)(5660300002)(53546011)(6512007)(83380400001)(2616005)(6916009)(52116002)(107886003)(966005)(26005)(6486002)(86362001)(186003)(66556008)(4326008)(8676002)(38350700002)(41300700001)(36756003)(2906002)(66946007)(6666004)(8936002)(30864003)(478600001)(66476007)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/hnmfii7vEMYawwVIQUaDdc8MKEMjsGWdGfAsG4cPDDtb6Ntku5OZDtndWN9?=
 =?us-ascii?Q?DBur+a1i28dwScMTo4cyIDXavn+Z16up2v7KZm36mS40BEfJ+lwMxbT9pHgx?=
 =?us-ascii?Q?f7sBI9dm8PfI0mR6+hNXXelhrYxH4AfWdNQJMMUSx2NxkvGG19f70Cd7EHdy?=
 =?us-ascii?Q?3wPjCwpH+Ic52MUX9d57GjzYJh87iYI3Jt/418Id9Nucrauc7BYQfjKEwZiJ?=
 =?us-ascii?Q?g0D2nbNC+YK3aqQc3vVdG9SUPv27URWmMsdD6CIbFE2VEXjOvFlawi7QzLNL?=
 =?us-ascii?Q?UcvXcvofV6bxFMhx1hb7Gah2+bd29xXOoC0tCNDss3Lw+oLBoGZESV+FASPW?=
 =?us-ascii?Q?4QUQa9PE2KCgPzUy/gzY0pd6Mq5eAClD6yIeilTF47Nc4MEF9YqqSUny6ApX?=
 =?us-ascii?Q?sXctAkhP3YFH6xSy3g0UzDcMNywMP35x+odx38VfJdY0mihKAITaifmgx4KK?=
 =?us-ascii?Q?7Goh+16YPNerx0tVICqFGwwstHWcqVPqilcyxrF/bn2UHEglyx0qf9yZJGQB?=
 =?us-ascii?Q?X/ZcKtVFAwVrllQm9H1UJUD+MRateiX2RaOvQgQ7dKmmk7e2IQqxdEPcLQ9l?=
 =?us-ascii?Q?VqtimnE/72fAzQC6TkhZecHpZIZxL9tp0B5oxUJWMtMeMbMU68dPu5Y9XRpC?=
 =?us-ascii?Q?rSL/4s/33MQ/6jeZJYO+7Xzc8R2+PXbmxET/1kMaC426TGy89D0ae1slb1md?=
 =?us-ascii?Q?ILHcVnoIbu9OU+yShHQtBWvuiKgbMeFPMWqBXDz/QT1i7NpmRHZ6ZYtb8Dus?=
 =?us-ascii?Q?tYExYMThKM0R2Q1UFYt+MDvnCY0QNY4qO+OpWyTUmRu1LfIGJwQRQR9XJPWt?=
 =?us-ascii?Q?tbxF4UYItBSgzHj+e9TwfKt/3BztfZ6m8TuJItYOn+XmEht2zSIOC/39aeW7?=
 =?us-ascii?Q?iRBf1iQLT9wPeJrl79yX+yzGPBMYGMlwfSXSJXIT+cIiSkxaXzTKaTkb0fcs?=
 =?us-ascii?Q?NkB/nFfIOS4dURj2LR9BvxLbKpcrbWx/85jdn9Kgs/2cQn1+OfvZhJe7RvQT?=
 =?us-ascii?Q?rASExN+AATAYLz9zRffralxqBwgqtL0f8fCS4uIBYgeb0Aj0hVEgNBnV+QjM?=
 =?us-ascii?Q?P7AU2eJZL67oo1eAWZ0X0Mp4dyElC4LEyCDo5ka4L+CnMtoElaYT5pYeOsPb?=
 =?us-ascii?Q?HkMnv/7YFnuAyyYmXimCKzFjOT3GAaWaubX552KWHDqAt9Zo14Zak2dPSoLx?=
 =?us-ascii?Q?JdPYSAGtOrFNbYswhu4Ji8D9sPsNFUc1AGlzLJNYdMsgMgV0dRpT3h81RIjI?=
 =?us-ascii?Q?r4JWax4YQQdWqpvaL9q5jorKNeqNYo1v0uDNlR9zDHIQQPOKk3q4iY/EgvwF?=
 =?us-ascii?Q?0Si24tP1WkhijIdeSK4ZsaP6qCPMguUHXyosARBHrJrVrDMtIeQ/mNlhdzT7?=
 =?us-ascii?Q?ynyavFcRKsWeDFREVtCS7MJyqEkK3J6b5efezhGM8v2/eV1GWaL0QrVZdk8R?=
 =?us-ascii?Q?K17eQJPYfMXBtQ/8B9HKQtnWhsCWk3ymAac000dPqTh3fPu7hlvuJe4aIdtZ?=
 =?us-ascii?Q?LsM8hRMrfsLAzUKwRPmxPHrHzBuezOdCsBOtTFYeAtyeeOCqCAHc9ZxYkAGW?=
 =?us-ascii?Q?Ilox1aopCyQLM/amNZFRviQHRxjOvH/lOJXCwwgU9wgoBxYt5epFHPj/pT0j?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a31c86f-42b2-4b0c-26c3-08da61fc301d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2022 22:41:39.7590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GAYXHTIGzK1F4R99Lp3j0hnkM5R4/sm+Zir+1SEgWitLHxGzxPBh7olGGYpMDJSzKRn4W4DnH0eFvhBxy5sXIKW4bY8JUqjZrDWSXDBZySs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1793
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-09_21:2022-07-08,2022-07-09 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2207090102
X-Proofpoint-GUID: vSVQRRQwoW42ySU1QdtNhSzqkTE8MqgD
X-Proofpoint-ORIG-GUID: vSVQRRQwoW42ySU1QdtNhSzqkTE8MqgD
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On Sat, Jul 9, 2022 at 2:32 PM James Hilliard <james.hilliard1@gmail.com> wrote:
>>
>> On Sat, Jul 9, 2022 at 2:21 PM Jose E. Marchesi
>> <jose.marchesi@oracle.com> wrote:
>> >
>> >
>> > > On Sat, Jul 9, 2022 at 11:24 AM Jose E. Marchesi
>> > > <jose.marchesi@oracle.com> wrote:
>> > >>
>> > >>
>> > >> > On Fri, Jul 8, 2022 at 12:33 PM Jose E. Marchesi
>> > >> > <jose.marchesi@oracle.com> wrote:
>> > >> >>
>> > >> >>
>> > >> >> >> On Wed, Jul 6, 2022 at 10:13 AM James Hilliard
>> > >> >> >> <james.hilliard1@gmail.com> wrote:
>> > >> >> >>>
>> > >> >> >>> Note I'm testing with the following patches:
>> > >> >> >>> https://lore.kernel.org/bpf/20220706111839.1247911-1-james.hilliard1@gmail.com/
>> > >> >> >>> https://lore.kernel.org/bpf/20220706140623.2917858-1-james.hilliard1@gmail.com/
>> > >> >> >>>
>> > >> >> >>> It would appear there's some compatibility issues with bpftool gen and
>> > >> >> >>> GCC, not sure what side though is wrong here:
>> > >> >> >>> /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > >> >> >>> gen object src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> > >> >> >>> src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> > >> >> >>> libbpf: failed to find BTF info for global/extern symbol 'sd_restrictif_i'
>> > >> >> >>> Error: failed to link
>> > >> >> >>> 'src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o':
>> > >> >> >>> Unknown error -2 (-2)
>> > >> >> >>>
>> > >> >> >>> Relevant difference seems to be this:
>> > >> >> >>> GCC:
>> > >> >> >>> [55] FUNC 'sd_restrictif_i' type_id=47 linkage=static
>> > >> >> >>> Clang:
>> > >> >> >>> [27] FUNC 'sd_restrictif_i' type_id=26 linkage=global
>> > >> >> >
>> > >> >> > For functions GCC generates a BTF_KIND_FUNC entry, which has no linkage
>> > >> >> > information, or so we thought: I just looked at bpftool/btf.c and I
>> > >> >> > found the linkage info for function types is expected to be encoded in
>> > >> >> > the vlen field of BTF_KIND_FUNC entries (why not adding a btf_func
>> > >> >> > instead???) which is surprising to say the least.
>> > >> >> >
>> > >> >> > We are changing GCC to encode the linkage info in vlen for these types.
>> > >> >> > Thanks for reporting this.
>> > >> >>
>> > >> >> Patch sent to GCC upstream:
>> > >> >> https://gcc.gnu.org/pipermail/gcc-patches/2022-July/598090.html
>> > >> >
>> > >> > I applied that patch on top of GCC 12.1.0 and it appears to fix the
>> > >> > bpftool gen object bug.
>> > >> >
>> > >> > I am however now hitting a different error during skeleton generation:
>> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > >> > gen skeleton src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> > >> > libbpf: elf: skipping unrecognized data section(9) .comment
>> > >> > libbpf: failed to alloc map 'restrict.bss' content buffer: -22
>> > >> > Error: failed to open BPF object file: Invalid argument
>> > >>
>> > >> What is the size of the .bss section in the object file?  Try with:
>> > >>
>> > >> $ size restrict-ifaces.bpf.o
>> > >
>> > > $ size
> output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> > >    text       data        bss        dec        hex    filename
>> > >     386         25          0        411        19b
>> > > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> >
>> > Right, so the .bss section is empty.  I see a `const volatile unsigned
>> > char is_allow_list = 0;' in restrict-ifaces.bpf.c, but that goes to
>> > .data and not to .bss, as expected.
>> >
>> > If you build restrict-ifaces.bpf.o with LLVM, is the bss still empty?  I
>> > don't think the code in libbpf.c even checks for this eventuality...
>>
>> LLVM version(which skeleton generation works with):
>> $ size restrict-ifaces.bpf.o
>>    text       data        bss        dec        hex    filename
>>     323         24          0        347        15b    restrict-ifaces.bpf.o
>>
>> $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> btf dump file restrict-ifaces.bpf.o format raw
>> [1] PTR '(anon)' type_id=3
>> [2] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> [3] ARRAY '(anon)' type_id=2 index_type_id=4 nr_elems=1
>> [4] INT '__ARRAY_SIZE_TYPE__' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> [5] PTR '(anon)' type_id=6
>> [6] TYPEDEF '__u32' type_id=7
>> [7] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> [8] PTR '(anon)' type_id=9
>> [9] TYPEDEF '__u8' type_id=10
>> [10] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=(none)
>> [11] STRUCT '(anon)' size=24 vlen=3
>>     'type' type_id=1 bits_offset=0
>>     'key' type_id=5 bits_offset=64
>>     'value' type_id=8 bits_offset=128
>> [12] VAR 'sd_restrictif' type_id=11, linkage=global
>> [13] PTR '(anon)' type_id=14
>> [14] CONST '(anon)' type_id=15
>> [15] STRUCT '__sk_buff' size=192 vlen=33
>>     'len' type_id=6 bits_offset=0
>>     'pkt_type' type_id=6 bits_offset=32
>>     'mark' type_id=6 bits_offset=64
>>     'queue_mapping' type_id=6 bits_offset=96
>>     'protocol' type_id=6 bits_offset=128
>>     'vlan_present' type_id=6 bits_offset=160
>>     'vlan_tci' type_id=6 bits_offset=192
>>     'vlan_proto' type_id=6 bits_offset=224
>>     'priority' type_id=6 bits_offset=256
>>     'ingress_ifindex' type_id=6 bits_offset=288
>>     'ifindex' type_id=6 bits_offset=320
>>     'tc_index' type_id=6 bits_offset=352
>>     'cb' type_id=16 bits_offset=384
>>     'hash' type_id=6 bits_offset=544
>>     'tc_classid' type_id=6 bits_offset=576
>>     'data' type_id=6 bits_offset=608
>>     'data_end' type_id=6 bits_offset=640
>>     'napi_id' type_id=6 bits_offset=672
>>     'family' type_id=6 bits_offset=704
>>     'remote_ip4' type_id=6 bits_offset=736
>>     'local_ip4' type_id=6 bits_offset=768
>>     'remote_ip6' type_id=17 bits_offset=800
>>     'local_ip6' type_id=17 bits_offset=928
>>     'remote_port' type_id=6 bits_offset=1056
>>     'local_port' type_id=6 bits_offset=1088
>>     'data_meta' type_id=6 bits_offset=1120
>>     '(anon)' type_id=18 bits_offset=1152
>>     'tstamp' type_id=20 bits_offset=1216
>>     'wire_len' type_id=6 bits_offset=1280
>>     'gso_segs' type_id=6 bits_offset=1312
>>     '(anon)' type_id=22 bits_offset=1344
>>     'gso_size' type_id=6 bits_offset=1408
>>     'hwtstamp' type_id=20 bits_offset=1472
>> [16] ARRAY '(anon)' type_id=6 index_type_id=4 nr_elems=5
>> [17] ARRAY '(anon)' type_id=6 index_type_id=4 nr_elems=4
>> [18] UNION '(anon)' size=8 vlen=1
>>     'flow_keys' type_id=19 bits_offset=0
>> [19] PTR '(anon)' type_id=34
>> [20] TYPEDEF '__u64' type_id=21
>> [21] INT 'unsigned long long' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>> [22] UNION '(anon)' size=8 vlen=1
>>     'sk' type_id=23 bits_offset=0
>> [23] PTR '(anon)' type_id=35
>> [24] FUNC_PROTO '(anon)' ret_type_id=2 vlen=1
>>     'sk' type_id=13
>> [25] FUNC 'sd_restrictif_e' type_id=24 linkage=global
>> [26] FUNC 'sd_restrictif_i' type_id=24 linkage=global
>> [27] CONST '(anon)' type_id=28
>> [28] VOLATILE '(anon)' type_id=9
>> [29] VAR 'is_allow_list' type_id=27, linkage=global
>> [30] CONST '(anon)' type_id=31
>> [31] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=SIGNED
>> [32] ARRAY '(anon)' type_id=30 index_type_id=4 nr_elems=18
>> [33] VAR '_license' type_id=32, linkage=static
>> [34] FWD 'bpf_flow_keys' fwd_kind=struct
>> [35] FWD 'bpf_sock' fwd_kind=struct
>> [36] DATASEC '.rodata' size=1 vlen=1
>>     type_id=29 offset=0 size=1 (VAR 'is_allow_list')
>> [37] DATASEC 'license' size=18 vlen=1
>>     type_id=33 offset=0 size=18 (VAR '_license')
>> [38] DATASEC '.maps' size=24 vlen=1
>>     type_id=12 offset=0 size=24 (VAR 'sd_restrictif')
>>
>
> Skeleton generation debug output for GCC(failing) and LLVM(working)
> which may be helpful:

Indeed it was helpful :)

The GNU assembler generates an empty .bss section.  This is a well
established behavior in GAS that happens in all supported targets.

The LLVM assembler doesn't generate an empty .bss section.

bpftool chokes on the empty .bss section.

In this case I would suggest to fix bpf_object__init_global_data_maps in
order to skip empty sections.

Something like this:

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index e89cc9c885b3..e3a6808f0bb6 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1591,6 +1591,10 @@ static int bpf_object__init_global_data_maps(struct bpf_object *obj)
 	for (sec_idx = 1; sec_idx < obj->efile.sec_cnt; sec_idx++) {
 		sec_desc = &obj->efile.secs[sec_idx];
 
+                /* Skip empty sections.  */
+                if (sec_desc->data->d_size == 0)
+                  continue;
+
 		switch (sec_desc->sec_type) {
 		case SEC_DATA:
 			sec_name = elf_sec_name(obj, elf_sec_by_idx(obj, sec_idx));

> GCC:
> $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> --debug gen skeleton
> output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
> libbpf: loading object 'restrict_ifaces_bpf' from buffer
> libbpf: elf: section(2) .symtab, size 336, link 1, flags 0, type=2
> libbpf: elf: section(3) .data, size 1, link 0, flags 3, type=1
> libbpf: elf: section(4) .bss, size 0, link 0, flags 3, type=8
> libbpf: elf: section(5) cgroup_skb/egress, size 184, link 0, flags 6, type=1
> libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
> insn offset 0 (0 bytes), code size 23 insns (184 bytes)
> libbpf: elf: section(6) cgroup_skb/ingress, size 184, link 0, flags 6, type=1
> libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' at
> insn offset 0 (0 bytes), code size 23 insns (184 bytes)
> libbpf: elf: section(7) license, size 18, link 0, flags 2, type=1
> libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
> libbpf: elf: section(8) .maps, size 24, link 0, flags 3, type=1
> libbpf: elf: section(9) .comment, size 49, link 0, flags 30, type=1
> libbpf: elf: skipping unrecognized data section(9) .comment
> libbpf: elf: section(10) .relcgroup_skb/egress, size 32, link 2, flags
> 40, type=9
> libbpf: elf: section(11) .relcgroup_skb/ingress, size 32, link 2,
> flags 40, type=9
> libbpf: elf: section(12) .BTF, size 3606, link 0, flags 0, type=1
> libbpf: looking for externs among 14 symbols...
> libbpf: collected 0 externs total
> libbpf: map 'sd_restrictif': at sec_idx 8, offset 0.
> libbpf: map 'sd_restrictif': found type = 1.
> libbpf: map 'sd_restrictif': found key [12], sz = 4.
> libbpf: map 'sd_restrictif': found value [3], sz = 1.
> libbpf: map 'restrict.data' (global data): at sec_idx 3, offset 0, flags 400.
> libbpf: map 1 is "restrict.data"
> libbpf: map 'restrict.bss' (global data): at sec_idx 4, offset 0, flags 400.
> libbpf: failed to alloc map 'restrict.bss' content buffer: -22
> Error: failed to open BPF object file: Invalid argument
>
> LLVM:
> $ /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
> --debug gen skeleton restrict-ifaces.bpf.o
> libbpf: loading object 'restrict_ifaces_bpf' from buffer
> libbpf: elf: section(2) .symtab, size 384, link 1, flags 0, type=2
> libbpf: elf: section(3) cgroup_skb/egress, size 152, link 0, flags 6, type=1
> libbpf: sec 'cgroup_skb/egress': found program 'sd_restrictif_e' at
> insn offset 0 (0 bytes), code size 19 insns (152 bytes)
> libbpf: elf: section(4) cgroup_skb/ingress, size 152, link 0, flags 6, type=1
> libbpf: sec 'cgroup_skb/ingress': found program 'sd_restrictif_i' at
> insn offset 0 (0 bytes), code size 19 insns (152 bytes)
> libbpf: elf: section(5) .rodata, size 1, link 0, flags 2, type=1
> libbpf: elf: section(6) license, size 18, link 0, flags 2, type=1
> libbpf: license of restrict_ifaces_bpf is LGPL-2.1-or-later
> libbpf: elf: section(7) .maps, size 24, link 0, flags 3, type=1
> libbpf: elf: section(8) .relcgroup_skb/egress, size 32, link 2, flags 40, type=9
> libbpf: elf: section(9) .relcgroup_skb/ingress, size 32, link 2, flags
> 40, type=9
> libbpf: elf: section(10) .BTF, size 1988, link 0, flags 0, type=1
> libbpf: elf: section(11) .BTF.ext, size 376, link 0, flags 0, type=1
> libbpf: looking for externs among 16 symbols...
> libbpf: collected 0 externs total
> libbpf: map 'sd_restrictif': at sec_idx 7, offset 0.
> libbpf: map 'sd_restrictif': found type = 1.
> libbpf: map 'sd_restrictif': found key [6], sz = 4.
> libbpf: map 'sd_restrictif': found value [9], sz = 1.
> libbpf: map 'restrict.rodata' (global data): at sec_idx 5, offset 0, flags 480.
> libbpf: map 1 is "restrict.rodata"
> libbpf: sec '.relcgroup_skb/egress': collecting relocation for
> section(3) 'cgroup_skb/egress'
> libbpf: sec '.relcgroup_skb/egress': relo #0: insn #4 against 'sd_restrictif'
> libbpf: prog 'sd_restrictif_e': found map 0 (sd_restrictif, sec 7, off
> 0) for insn #4
> libbpf: sec '.relcgroup_skb/egress': relo #1: insn #7 against 'is_allow_list'
> libbpf: prog 'sd_restrictif_e': found data map 1 (restrict.rodata, sec
> 5, off 0) for insn 7
> libbpf: sec '.relcgroup_skb/ingress': collecting relocation for
> section(4) 'cgroup_skb/ingress'
> libbpf: sec '.relcgroup_skb/ingress': relo #0: insn #4 against 'sd_restrictif'
> libbpf: prog 'sd_restrictif_i': found map 0 (sd_restrictif, sec 7, off
> 0) for insn #4
> libbpf: sec '.relcgroup_skb/ingress': relo #1: insn #7 against 'is_allow_list'
> libbpf: prog 'sd_restrictif_i': found data map 1 (restrict.rodata, sec
> 5, off 0) for insn 7
>
>> >
>> > >>
>> > >> Looking at libbpf.c, it seems to me that this may be due of trying to
>> > >> mmap 0 bytes in `bpf_object__init_internal_map':
>> > >>
>> > >>         map->mmaped = mmap(NULL, bpf_map_mmap_sz(map), PROT_READ | PROT_WRITE,
>> > >>                            MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>> > >>         if (map->mmaped == MAP_FAILED) {
>> > >>                 err = -errno;
>> > >>                 map->mmaped = NULL;
>> > >>                 pr_warn("failed to alloc map '%s' content buffer: %d\n",
>> > >>                         map->name, err);
>> > >>                 zfree(&map->real_name);
>> > >>                 zfree(&map->name);
>> > >>                 return err;
>> > >>         }
>> > >>
>> > >> I see no check for zero sized sections in
>> > >> bpf_object__init_global_data_maps.
>> > >>
>> > >> Is maybe GCC failing to allocate stuff in BSS that is supposed to be
>> > >> there?
>> > >>
>> > >> > Stripped file passed to gen skeleton:
>> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > >> > btf dump file
>> > >> > output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.o
>> > >> > format raw
>> > >> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> > >> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> > >> > [3] TYPEDEF '__u8' type_id=2
>> > >> > [4] CONST '(anon)' type_id=3
>> > >> > [5] VOLATILE '(anon)' type_id=4
>> > >> > [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
>> > >> > [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
>> > >> > [8] TYPEDEF '__u16' type_id=7
>> > >> > [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> > >> > [10] TYPEDEF '__s32' type_id=9
>> > >> > [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> > >> > [12] TYPEDEF '__u32' type_id=11
>> > >> > [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> > >> > [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
>> > >> > encoding=(none)
>> > >> > [15] TYPEDEF '__u64' type_id=14
>> > >> > [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>> > >> > [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> > >> > [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> > >> > [19] CONST '(anon)' type_id=18
>> > >> > [20] TYPEDEF '__be16' type_id=8
>> > >> > [21] TYPEDEF '__be32' type_id=12
>> > >> > [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
>> > >> >     'BPF_MAP_TYPE_UNSPEC' val=0
>> > >> >     'BPF_MAP_TYPE_HASH' val=1
>> > >> >     'BPF_MAP_TYPE_ARRAY' val=2
>> > >> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3
>> > >> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
>> > >> >     'BPF_MAP_TYPE_PERCPU_HASH' val=5
>> > >> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
>> > >> >     'BPF_MAP_TYPE_STACK_TRACE' val=7
>> > >> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
>> > >> >     'BPF_MAP_TYPE_LRU_HASH' val=9
>> > >> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
>> > >> >     'BPF_MAP_TYPE_LPM_TRIE' val=11
>> > >> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
>> > >> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
>> > >> >     'BPF_MAP_TYPE_DEVMAP' val=14
>> > >> >     'BPF_MAP_TYPE_SOCKMAP' val=15
>> > >> >     'BPF_MAP_TYPE_CPUMAP' val=16
>> > >> >     'BPF_MAP_TYPE_XSKMAP' val=17
>> > >> >     'BPF_MAP_TYPE_SOCKHASH' val=18
>> > >> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
>> > >> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
>> > >> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
>> > >> >     'BPF_MAP_TYPE_QUEUE' val=22
>> > >> >     'BPF_MAP_TYPE_STACK' val=23
>> > >> >     'BPF_MAP_TYPE_SK_STORAGE' val=24
>> > >> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
>> > >> >     'BPF_MAP_TYPE_STRUCT_OPS' val=26
>> > >> >     'BPF_MAP_TYPE_RINGBUF' val=27
>> > >> >     'BPF_MAP_TYPE_INODE_STORAGE' val=28
>> > >> >     'BPF_MAP_TYPE_TASK_STORAGE' val=29
>> > >> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
>> > >> > [23] UNION '(anon)' size=8 vlen=1
>> > >> >     'flow_keys' type_id=29 bits_offset=0
>> > >> > [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
>> > >> >     'nhoff' type_id=8 bits_offset=0
>> > >> >     'thoff' type_id=8 bits_offset=16
>> > >> >     'addr_proto' type_id=8 bits_offset=32
>> > >> >     'is_frag' type_id=3 bits_offset=48
>> > >> >     'is_first_frag' type_id=3 bits_offset=56
>> > >> >     'is_encap' type_id=3 bits_offset=64
>> > >> >     'ip_proto' type_id=3 bits_offset=72
>> > >> >     'n_proto' type_id=20 bits_offset=80
>> > >> >     'sport' type_id=20 bits_offset=96
>> > >> >     'dport' type_id=20 bits_offset=112
>> > >> >     '(anon)' type_id=25 bits_offset=128
>> > >> >     'flags' type_id=12 bits_offset=384
>> > >> >     'flow_label' type_id=21 bits_offset=416
>> > >> > [25] UNION '(anon)' size=32 vlen=2
>> > >> >     '(anon)' type_id=26 bits_offset=0
>> > >> >     '(anon)' type_id=27 bits_offset=0
>> > >> > [26] STRUCT '(anon)' size=8 vlen=2
>> > >> >     'ipv4_src' type_id=21 bits_offset=0
>> > >> >     'ipv4_dst' type_id=21 bits_offset=32
>> > >> > [27] STRUCT '(anon)' size=32 vlen=2
>> > >> >     'ipv6_src' type_id=28 bits_offset=0
>> > >> >     'ipv6_dst' type_id=28 bits_offset=128
>> > >> > [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
>> > >> > [29] PTR '(anon)' type_id=24
>> > >> > [30] UNION '(anon)' size=8 vlen=1
>> > >> >     'sk' type_id=32 bits_offset=0
>> > >> > [31] STRUCT 'bpf_sock' size=80 vlen=14
>> > >> >     'bound_dev_if' type_id=12 bits_offset=0
>> > >> >     'family' type_id=12 bits_offset=32
>> > >> >     'type' type_id=12 bits_offset=64
>> > >> >     'protocol' type_id=12 bits_offset=96
>> > >> >     'mark' type_id=12 bits_offset=128
>> > >> >     'priority' type_id=12 bits_offset=160
>> > >> >     'src_ip4' type_id=12 bits_offset=192
>> > >> >     'src_ip6' type_id=28 bits_offset=224
>> > >> >     'src_port' type_id=12 bits_offset=352
>> > >> >     'dst_port' type_id=20 bits_offset=384
>> > >> >     'dst_ip4' type_id=12 bits_offset=416
>> > >> >     'dst_ip6' type_id=28 bits_offset=448
>> > >> >     'state' type_id=12 bits_offset=576
>> > >> >     'rx_queue_mapping' type_id=10 bits_offset=608
>> > >> > [32] PTR '(anon)' type_id=31
>> > >> > [33] STRUCT '__sk_buff' size=192 vlen=33
>> > >> >     'len' type_id=12 bits_offset=0
>> > >> >     'pkt_type' type_id=12 bits_offset=32
>> > >> >     'mark' type_id=12 bits_offset=64
>> > >> >     'queue_mapping' type_id=12 bits_offset=96
>> > >> >     'protocol' type_id=12 bits_offset=128
>> > >> >     'vlan_present' type_id=12 bits_offset=160
>> > >> >     'vlan_tci' type_id=12 bits_offset=192
>> > >> >     'vlan_proto' type_id=12 bits_offset=224
>> > >> >     'priority' type_id=12 bits_offset=256
>> > >> >     'ingress_ifindex' type_id=12 bits_offset=288
>> > >> >     'ifindex' type_id=12 bits_offset=320
>> > >> >     'tc_index' type_id=12 bits_offset=352
>> > >> >     'cb' type_id=34 bits_offset=384
>> > >> >     'hash' type_id=12 bits_offset=544
>> > >> >     'tc_classid' type_id=12 bits_offset=576
>> > >> >     'data' type_id=12 bits_offset=608
>> > >> >     'data_end' type_id=12 bits_offset=640
>> > >> >     'napi_id' type_id=12 bits_offset=672
>> > >> >     'family' type_id=12 bits_offset=704
>> > >> >     'remote_ip4' type_id=12 bits_offset=736
>> > >> >     'local_ip4' type_id=12 bits_offset=768
>> > >> >     'remote_ip6' type_id=28 bits_offset=800
>> > >> >     'local_ip6' type_id=28 bits_offset=928
>> > >> >     'remote_port' type_id=12 bits_offset=1056
>> > >> >     'local_port' type_id=12 bits_offset=1088
>> > >> >     'data_meta' type_id=12 bits_offset=1120
>> > >> >     '(anon)' type_id=23 bits_offset=1152
>> > >> >     'tstamp' type_id=15 bits_offset=1216
>> > >> >     'wire_len' type_id=12 bits_offset=1280
>> > >> >     'gso_segs' type_id=12 bits_offset=1312
>> > >> >     '(anon)' type_id=30 bits_offset=1344
>> > >> >     'gso_size' type_id=12 bits_offset=1408
>> > >> >     'hwtstamp' type_id=15 bits_offset=1472
>> > >> > [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
>> > >> > [35] CONST '(anon)' type_id=33
>> > >> > [36] PTR '(anon)' type_id=0
>> > >> > [37] STRUCT '(anon)' size=24 vlen=3
>> > >> >     'type' type_id=39 bits_offset=0
>> > >> >     'key' type_id=40 bits_offset=64
>> > >> >     'value' type_id=41 bits_offset=128
>> > >> > [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
>> > >> > [39] PTR '(anon)' type_id=38
>> > >> > [40] PTR '(anon)' type_id=12
>> > >> > [41] PTR '(anon)' type_id=3
>> > >> > [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
>> > >> > [43] CONST '(anon)' type_id=42
>> > >> > [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
>> > >> >     '(anon)' type_id=36
>> > >> >     '(anon)' type_id=46
>> > >> > [45] CONST '(anon)' type_id=0
>> > >> > [46] PTR '(anon)' type_id=45
>> > >> > [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> > >> >     'sk' type_id=48
>> > >> > [48] PTR '(anon)' type_id=35
>> > >> > [49] VAR '_license' type_id=43, linkage=static
>> > >> > [50] VAR 'is_allow_list' type_id=5, linkage=global
>> > >> > [51] VAR 'sd_restrictif' type_id=37, linkage=global
>> > >> > [52] FUNC 'sd_restrictif_i' type_id=47 linkage=global
>> > >> > [53] FUNC 'sd_restrictif_e' type_id=47 linkage=global
>> > >> > [54] FUNC 'restrict_network_interfaces_impl' type_id=47 linkage=static
>> > >> > [55] DATASEC '.data' size=1 vlen=1
>> > >> >     type_id=50 offset=0 size=1 (VAR 'is_allow_list')
>> > >> > [56] DATASEC 'license' size=18 vlen=1
>> > >> >     type_id=49 offset=0 size=18 (VAR '_license')
>> > >> > [57] DATASEC '.maps' size=24 vlen=1
>> > >> >     type_id=51 offset=0 size=24 (VAR 'sd_restrictif')
>> > >> >
>> > >> > File before being stripped using bpftool gen object:
>> > >> > /home/buildroot/buildroot/output/per-package/systemd/host/sbin/bpftool
>> > >> > btf dump file
>> > >> >
> output/build/systemd-custom/build/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.unstripped.o
>> > >> > format raw
>> > >> > [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> > >> > [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> > >> > [3] TYPEDEF '__u8' type_id=2
>> > >> > [4] CONST '(anon)' type_id=3
>> > >> > [5] VOLATILE '(anon)' type_id=4
>> > >> > [6] INT 'short int' size=2 bits_offset=0 nr_bits=16 encoding=SIGNED
>> > >> > [7] INT 'short unsigned int' size=2 bits_offset=0 nr_bits=16 encoding=(none)
>> > >> > [8] TYPEDEF '__u16' type_id=7
>> > >> > [9] INT 'int' size=4 bits_offset=0 nr_bits=32 encoding=SIGNED
>> > >> > [10] TYPEDEF '__s32' type_id=9
>> > >> > [11] INT 'unsigned int' size=4 bits_offset=0 nr_bits=32 encoding=(none)
>> > >> > [12] TYPEDEF '__u32' type_id=11
>> > >> > [13] INT 'long long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> > >> > [14] INT 'long long unsigned int' size=8 bits_offset=0 nr_bits=64
>> > >> > encoding=(none)
>> > >> > [15] TYPEDEF '__u64' type_id=14
>> > >> > [16] INT 'long unsigned int' size=8 bits_offset=0 nr_bits=64 encoding=(none)
>> > >> > [17] INT 'long int' size=8 bits_offset=0 nr_bits=64 encoding=SIGNED
>> > >> > [18] INT 'char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> > >> > [19] CONST '(anon)' type_id=18
>> > >> > [20] TYPEDEF '__be16' type_id=8
>> > >> > [21] TYPEDEF '__be32' type_id=12
>> > >> > [22] ENUM 'bpf_map_type' encoding=UNSIGNED size=4 vlen=31
>> > >> >     'BPF_MAP_TYPE_UNSPEC' val=0
>> > >> >     'BPF_MAP_TYPE_HASH' val=1
>> > >> >     'BPF_MAP_TYPE_ARRAY' val=2
>> > >> >     'BPF_MAP_TYPE_PROG_ARRAY' val=3
>> > >> >     'BPF_MAP_TYPE_PERF_EVENT_ARRAY' val=4
>> > >> >     'BPF_MAP_TYPE_PERCPU_HASH' val=5
>> > >> >     'BPF_MAP_TYPE_PERCPU_ARRAY' val=6
>> > >> >     'BPF_MAP_TYPE_STACK_TRACE' val=7
>> > >> >     'BPF_MAP_TYPE_CGROUP_ARRAY' val=8
>> > >> >     'BPF_MAP_TYPE_LRU_HASH' val=9
>> > >> >     'BPF_MAP_TYPE_LRU_PERCPU_HASH' val=10
>> > >> >     'BPF_MAP_TYPE_LPM_TRIE' val=11
>> > >> >     'BPF_MAP_TYPE_ARRAY_OF_MAPS' val=12
>> > >> >     'BPF_MAP_TYPE_HASH_OF_MAPS' val=13
>> > >> >     'BPF_MAP_TYPE_DEVMAP' val=14
>> > >> >     'BPF_MAP_TYPE_SOCKMAP' val=15
>> > >> >     'BPF_MAP_TYPE_CPUMAP' val=16
>> > >> >     'BPF_MAP_TYPE_XSKMAP' val=17
>> > >> >     'BPF_MAP_TYPE_SOCKHASH' val=18
>> > >> >     'BPF_MAP_TYPE_CGROUP_STORAGE' val=19
>> > >> >     'BPF_MAP_TYPE_REUSEPORT_SOCKARRAY' val=20
>> > >> >     'BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE' val=21
>> > >> >     'BPF_MAP_TYPE_QUEUE' val=22
>> > >> >     'BPF_MAP_TYPE_STACK' val=23
>> > >> >     'BPF_MAP_TYPE_SK_STORAGE' val=24
>> > >> >     'BPF_MAP_TYPE_DEVMAP_HASH' val=25
>> > >> >     'BPF_MAP_TYPE_STRUCT_OPS' val=26
>> > >> >     'BPF_MAP_TYPE_RINGBUF' val=27
>> > >> >     'BPF_MAP_TYPE_INODE_STORAGE' val=28
>> > >> >     'BPF_MAP_TYPE_TASK_STORAGE' val=29
>> > >> >     'BPF_MAP_TYPE_BLOOM_FILTER' val=30
>> > >> > [23] UNION '(anon)' size=8 vlen=1
>> > >> >     'flow_keys' type_id=29 bits_offset=0
>> > >> > [24] STRUCT 'bpf_flow_keys' size=56 vlen=13
>> > >> >     'nhoff' type_id=8 bits_offset=0
>> > >> >     'thoff' type_id=8 bits_offset=16
>> > >> >     'addr_proto' type_id=8 bits_offset=32
>> > >> >     'is_frag' type_id=3 bits_offset=48
>> > >> >     'is_first_frag' type_id=3 bits_offset=56
>> > >> >     'is_encap' type_id=3 bits_offset=64
>> > >> >     'ip_proto' type_id=3 bits_offset=72
>> > >> >     'n_proto' type_id=20 bits_offset=80
>> > >> >     'sport' type_id=20 bits_offset=96
>> > >> >     'dport' type_id=20 bits_offset=112
>> > >> >     '(anon)' type_id=25 bits_offset=128
>> > >> >     'flags' type_id=12 bits_offset=384
>> > >> >     'flow_label' type_id=21 bits_offset=416
>> > >> > [25] UNION '(anon)' size=32 vlen=2
>> > >> >     '(anon)' type_id=26 bits_offset=0
>> > >> >     '(anon)' type_id=27 bits_offset=0
>> > >> > [26] STRUCT '(anon)' size=8 vlen=2
>> > >> >     'ipv4_src' type_id=21 bits_offset=0
>> > >> >     'ipv4_dst' type_id=21 bits_offset=32
>> > >> > [27] STRUCT '(anon)' size=32 vlen=2
>> > >> >     'ipv6_src' type_id=28 bits_offset=0
>> > >> >     'ipv6_dst' type_id=28 bits_offset=128
>> > >> > [28] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=4
>> > >> > [29] PTR '(anon)' type_id=24
>> > >> > [30] UNION '(anon)' size=8 vlen=1
>> > >> >     'sk' type_id=32 bits_offset=0
>> > >> > [31] STRUCT 'bpf_sock' size=80 vlen=14
>> > >> >     'bound_dev_if' type_id=12 bits_offset=0
>> > >> >     'family' type_id=12 bits_offset=32
>> > >> >     'type' type_id=12 bits_offset=64
>> > >> >     'protocol' type_id=12 bits_offset=96
>> > >> >     'mark' type_id=12 bits_offset=128
>> > >> >     'priority' type_id=12 bits_offset=160
>> > >> >     'src_ip4' type_id=12 bits_offset=192
>> > >> >     'src_ip6' type_id=28 bits_offset=224
>> > >> >     'src_port' type_id=12 bits_offset=352
>> > >> >     'dst_port' type_id=20 bits_offset=384
>> > >> >     'dst_ip4' type_id=12 bits_offset=416
>> > >> >     'dst_ip6' type_id=28 bits_offset=448
>> > >> >     'state' type_id=12 bits_offset=576
>> > >> >     'rx_queue_mapping' type_id=10 bits_offset=608
>> > >> > [32] PTR '(anon)' type_id=31
>> > >> > [33] STRUCT '__sk_buff' size=192 vlen=33
>> > >> >     'len' type_id=12 bits_offset=0
>> > >> >     'pkt_type' type_id=12 bits_offset=32
>> > >> >     'mark' type_id=12 bits_offset=64
>> > >> >     'queue_mapping' type_id=12 bits_offset=96
>> > >> >     'protocol' type_id=12 bits_offset=128
>> > >> >     'vlan_present' type_id=12 bits_offset=160
>> > >> >     'vlan_tci' type_id=12 bits_offset=192
>> > >> >     'vlan_proto' type_id=12 bits_offset=224
>> > >> >     'priority' type_id=12 bits_offset=256
>> > >> >     'ingress_ifindex' type_id=12 bits_offset=288
>> > >> >     'ifindex' type_id=12 bits_offset=320
>> > >> >     'tc_index' type_id=12 bits_offset=352
>> > >> >     'cb' type_id=34 bits_offset=384
>> > >> >     'hash' type_id=12 bits_offset=544
>> > >> >     'tc_classid' type_id=12 bits_offset=576
>> > >> >     'data' type_id=12 bits_offset=608
>> > >> >     'data_end' type_id=12 bits_offset=640
>> > >> >     'napi_id' type_id=12 bits_offset=672
>> > >> >     'family' type_id=12 bits_offset=704
>> > >> >     'remote_ip4' type_id=12 bits_offset=736
>> > >> >     'local_ip4' type_id=12 bits_offset=768
>> > >> >     'remote_ip6' type_id=28 bits_offset=800
>> > >> >     'local_ip6' type_id=28 bits_offset=928
>> > >> >     'remote_port' type_id=12 bits_offset=1056
>> > >> >     'local_port' type_id=12 bits_offset=1088
>> > >> >     'data_meta' type_id=12 bits_offset=1120
>> > >> >     '(anon)' type_id=23 bits_offset=1152
>> > >> >     'tstamp' type_id=15 bits_offset=1216
>> > >> >     'wire_len' type_id=12 bits_offset=1280
>> > >> >     'gso_segs' type_id=12 bits_offset=1312
>> > >> >     '(anon)' type_id=30 bits_offset=1344
>> > >> >     'gso_size' type_id=12 bits_offset=1408
>> > >> >     'hwtstamp' type_id=15 bits_offset=1472
>> > >> > [34] ARRAY '(anon)' type_id=12 index_type_id=16 nr_elems=5
>> > >> > [35] CONST '(anon)' type_id=33
>> > >> > [36] PTR '(anon)' type_id=0
>> > >> > [37] STRUCT '(anon)' size=24 vlen=3
>> > >> >     'type' type_id=39 bits_offset=0
>> > >> >     'key' type_id=40 bits_offset=64
>> > >> >     'value' type_id=41 bits_offset=128
>> > >> > [38] ARRAY '(anon)' type_id=9 index_type_id=16 nr_elems=1
>> > >> > [39] PTR '(anon)' type_id=38
>> > >> > [40] PTR '(anon)' type_id=12
>> > >> > [41] PTR '(anon)' type_id=3
>> > >> > [42] ARRAY '(anon)' type_id=19 index_type_id=16 nr_elems=18
>> > >> > [43] CONST '(anon)' type_id=42
>> > >> > [44] FUNC_PROTO '(anon)' ret_type_id=36 vlen=2
>> > >> >     '(anon)' type_id=36
>> > >> >     '(anon)' type_id=46
>> > >> > [45] CONST '(anon)' type_id=0
>> > >> > [46] PTR '(anon)' type_id=45
>> > >> > [47] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> > >> >     'sk' type_id=48
>> > >> > [48] PTR '(anon)' type_id=35
>> > >> > [49] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> > >> >     'sk' type_id=48
>> > >> > [50] FUNC_PROTO '(anon)' ret_type_id=9 vlen=1
>> > >> >     'sk' type_id=48
>> > >> > [51] VAR '_license' type_id=43, linkage=static
>> > >> > [52] VAR 'is_allow_list' type_id=5, linkage=global
>> > >> > [53] VAR 'sd_restrictif' type_id=37, linkage=global
>> > >> > [54] FUNC 'bpf_map_lookup_elem' type_id=44 linkage=global
>> > >> > [55] FUNC 'sd_restrictif_i' type_id=47 linkage=global
>> > >> > [56] FUNC 'sd_restrictif_e' type_id=49 linkage=global
>> > >> > [57] FUNC 'restrict_network_interfaces_impl' type_id=50 linkage=static
>> > >> > [58] DATASEC 'license' size=0 vlen=1
>> > >> >     type_id=51 offset=0 size=18 (VAR '_license')
>> > >> > [59] DATASEC '.maps' size=0 vlen=1
>> > >> >     type_id=53 offset=0 size=24 (VAR 'sd_restrictif')
>> > >> > [60] DATASEC '.data' size=0 vlen=1
>> > >> >     type_id=52 offset=0 size=1 (VAR 'is_allow_list')
>> > >> >
>> > >> >>
>> > >> >> >> GCC is wrong, clearly. This function is global ([0]) and libbpf
>> > >> >> >> expects it to be marked as such in BTF.
>> > >> >> >>
>> > >> >> >>
>> > >> >
> https://github.com/systemd/systemd/blob/main/src/core/bpf/restrict_ifaces/restrict-ifaces.bpf.c#L42-L50
>> > >> >> >>
>> > >> >> >>
>> > >> >> >>> GCC:
>> > >> >> >>>
>> > >> >> >>> [1] INT 'signed char' size=1 bits_offset=0 nr_bits=8 encoding=UNKN
>> > >> >> >>> [2] INT 'unsigned char' size=1 bits_offset=0 nr_bits=8 encoding=CHAR
>> > >> >> >>> [3] TYPEDEF '__u8' type_id=2
>> > >> >> >>> [4] CONST '(anon)' type_id=3
>> > >> >> >>
>> > >> >> >> [...]

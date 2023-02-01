Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F540686D69
	for <lists+bpf@lfdr.de>; Wed,  1 Feb 2023 18:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjBARvX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Feb 2023 12:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbjBARvW (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 1 Feb 2023 12:51:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C93B451
        for <bpf@vger.kernel.org>; Wed,  1 Feb 2023 09:51:20 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 311FZFAE007273;
        Wed, 1 Feb 2023 17:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=uOSJT2+oX9U/Yjxgot0FeyEGl+rNbflcemy29Kqfv0A=;
 b=IpE6qTpRXV3iqx3F/1oSOvvLHK/TgPxNN8lGCFdCuaKiI3snzZc+H37IM9bb3NtHz1j7
 R5Iz+WPKPJIZ6ikemVu3Vz6DpinvYmZnSf16l2/2JS/zoq7leJ+SgtIn1PBy06KXczc/
 rT85ApqMVz9vo7dQcSSR7vy8MwGIE+pObjLOd1wUUdE6KWyoh5wu9z6DmI3LZZDpUajZ
 7UOPH08ZpLtBYVmDnEMp76HvWBprq3TrbcAeTicNS8JYNNCa9ypaNEXibZpdfKOx8p47
 zi9GDAdfWdWDTapWV8oCgFYWs6DHzDjzMZvhN/z/wkjjWbNBONNJ2yUdUmghESECVYbV 1w== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nfpywgx07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 17:50:57 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 311GOnAi033901;
        Wed, 1 Feb 2023 17:50:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nct57m2pv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 01 Feb 2023 17:50:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kmKsoZ2S1TppkUrlcyS/X37PwE0jt9Vu79a2AFLK9EvA2xtUqgDZk+braLJpHOViRKMUO1Y5rPTruBqltjH/cvLKc2NH30n6Q7JXY/W6+q4sj6kOwEv8d7aQWvLdU4oaKQBlwqns//6onh33N/o+6yPq/vKpi39nOOcS3BRYApaxRIVnHnpkJO9QtOT/95IrI4W2g3wmNI9ZJ2dXOosI+c5Nqrsj66yosD9O9lzidbtEJcf3n+8OV9nQCqD9aplXXAKTvIo0eXflk8d+rZv0cnfEtbnMSKaZdhaNHdnC022kjj9E8Satp2/5GtAxy2KWc1328EewLdKBJjJFAYfGFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uOSJT2+oX9U/Yjxgot0FeyEGl+rNbflcemy29Kqfv0A=;
 b=gPd/+1kPRAMPQstN039DIel0Abx9m7P823tymkrasjyO1wbOBvyz9tp7GuJRVeP8aNGzoqC0wKgX1w0HcWRZ1Ysyi7n8ywl6ATnNq+f88tdzvtpI9iN4Dd4kQ5yewJaWM9V6foZj8ANmzN9irkXHJItNzEx7dgbDSrXgam78SAUooS/GQrGwpUYv1dQDhho5LQNfquQo7w1GOzCrXFZL2q3zkMDcpmdFIrQ6aqPZQFxWK1MB6mGdlvSi6hA1kX0MwvPrGle6zgxtAhPFYIZArOQriXxQ6byAAUl3Y03j4ZeBnKZfpExDzAfrwxKR1XOUHdy4j7PWdSdArt0Fef6vnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOSJT2+oX9U/Yjxgot0FeyEGl+rNbflcemy29Kqfv0A=;
 b=Zy1EkEN6AOnuZAPtMBr1LbdovshTjaRiso3T1DvOz1Ko8w0A21agZjOHjn1WTkODt+USQJtPkQa2vvyZfkkGRmoMrUGpDZnFBsHUNIfvtQEKcU4INs54AbEVRXPb+n/VctIRW0KSPOSe4W6PnqWLxyFrplpUtVfr17iR2Ono/Q4=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MW5PR10MB5665.namprd10.prod.outlook.com (2603:10b6:303:19a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6064.24; Wed, 1 Feb
 2023 17:50:54 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::d952:73ee:eb09:e05e%7]) with mapi id 15.20.6064.025; Wed, 1 Feb 2023
 17:50:54 +0000
Subject: Re: [PATCH v2 dwarves 2/5] btf_encoder: refactor function addition
 into dedicated btf_encoder__add_func
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     yhs@fb.com, ast@kernel.org, olsajiri@gmail.com, eddyz87@gmail.com,
        sinquersw@gmail.com, timo@incline.eu, daniel@iogearbox.net,
        andrii@kernel.org, songliubraving@fb.com, john.fastabend@gmail.com,
        kpsingh@chromium.org, sdf@google.com, haoluo@google.com,
        martin.lau@kernel.org, bpf@vger.kernel.org
References: <1675088985-20300-1-git-send-email-alan.maguire@oracle.com>
 <1675088985-20300-3-git-send-email-alan.maguire@oracle.com>
 <Y9qfMMrdro8PK5J1@kernel.org>
From:   Alan Maguire <alan.maguire@oracle.com>
Message-ID: <9d06aa0a-2d46-9bce-7911-8c976e162c51@oracle.com>
Date:   Wed, 1 Feb 2023 17:50:45 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
In-Reply-To: <Y9qfMMrdro8PK5J1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0560.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MW5PR10MB5665:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f7e7c10-8232-43bc-b99e-08db047cdd3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zfaVtHgJxkq6vuLT2zntP0nnpu6mNig/VquosDjm2xYyCtyZ17VOrB14jNCB7vSDWK1kZRFTJWwovpK5RJtssepSj7ztkWjVVE1f+O6DXTd+tR4P0r8T+4HoTJtd64WGCe4DluS6J495ZqLy25BPk22CoWVniJs45ZIvnjgpPqJsH59SKh7P7LO7/9MJp2MIsfolC+uyN1bJmALIpMew1A2vpAEl2xt/77svQSgUP8BJ6/YUD21ME6Y9q1cMs8lV8y2Tdrh1VScVWKo2bRj+HGiayjT/E9hP6DH/w3qB/XKJliwihyQ33xrJQzK8rCBMFvwwqbyy9dML96tNQlvHQsPcK+msXekuF7YAKhnBXsWOri4uSpPxVV4wwlpyRrFlaYAirG3ScThbfwoZilGDmc3aP6e6B1tqxtnaNNnmg+BGTi3oz5PmRD4UkteCo+nsNxq6KHdVV78jPibO9IscGFs5VqQ7UP0xE1H918WQMZIaMa8T8l2J+uk1UJqH7YKCwb0CigiRfDMiVhsf0/PiPmAGoLh1ym6RbqDy4rc+LTZfPxVfHCywxbW24JqEhmTtyyS/0edtaALOsMj3MnZfFk4hMmayF+VBpjwD7bN5aCLEqhkzFfUZhnGURyaylf8KPzbI2WURek2kKXRIUgkD3PDRtNYOlxGvEfr7oNFRy7UynXTDZPEe7LeFshxtonpf47IVxpgig4zXiwUevSOIvrw9XaFANlsUpTXL1g79QGoXo+a3r8E6hn6lo0RWxSqCd+KJUBGgFxHGJPPB4ogCJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(366004)(376002)(396003)(346002)(39860400002)(136003)(451199018)(7416002)(30864003)(6916009)(4326008)(8676002)(36756003)(44832011)(66556008)(66946007)(66476007)(38100700002)(83380400001)(2906002)(31696002)(2616005)(86362001)(6506007)(316002)(53546011)(478600001)(186003)(6486002)(6666004)(31686004)(66899018)(6512007)(5660300002)(8936002)(41300700001)(101420200003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekZVUFpiZWZyQ0cxYnc4R01sRXJDYzhXZzJCVzArT21vQTNKVUdFaUxvT2V4?=
 =?utf-8?B?c0xSVnlWRVcxSU9manVxRS9ORmNCTEtrcm03aWJsSTl4WVZQT2xZRzJvZmg0?=
 =?utf-8?B?Q1dodFUzS0F4WUdMT0UreGJReXhYMWhZZVBXSGU3bGFtbnBqendvbGFVT3Uy?=
 =?utf-8?B?M1hZZlRLS2wwQXdXQjhrM2ZhZTNMRG11NDU3dkdOK2RxcWJZZC82ZndCZGZF?=
 =?utf-8?B?YytRVE96WFV6Z0RZMGhCOVVyVGRDRndOOGNEMGpsYlN4TWpTQVlwNGRhUUZR?=
 =?utf-8?B?YUJLL1F6NG11WjFtVFA3K011enVWeFFvNzExMDlrS3F5N3FuU1orMmZ1MnN3?=
 =?utf-8?B?K3NUUjlTbEZGb3luTm5DN21Lc3ArUFZqNkdlU1htSmFQNEFXVzZka25NR2ZC?=
 =?utf-8?B?L0JOeVZ4U3BvMjFzNHJsbUx1dmM2TjdweHR2ZDU2SUIrengwa29vR09Kbm8x?=
 =?utf-8?B?bElMekd0eEk3dG83V1RNSEE0SUJ1eFhUN2dtM1d6OXFCNnB3TlNiUi9lbHoz?=
 =?utf-8?B?c1NTZHY5akY0WUdZeXA2TkRnOVVhdXJJUm1YaW9IK0ozU3dnamNsNGE0ay8v?=
 =?utf-8?B?QUFOQ1RWOFF0VkRyZ0x1dCtsT3JDVzRpSnNFbHE2N0UyRXZBR29mRFRHUVNq?=
 =?utf-8?B?a1VIRFNOb2VRdU5Uc1Z6cGpEUTJlOW1qTFdhWDE1aHozTk5YYTdrc2JHa2VT?=
 =?utf-8?B?SDZybXIzRlNMaFVTWmY3ZjhiWnJaSjZqazZyU294MG54RWVia3BZRGJKNW5B?=
 =?utf-8?B?MVNhN2M2TmxocEZTcjFaYnMxbXY1aU5qSVFDL01vRitZa2NnWmdMRFMzUEcx?=
 =?utf-8?B?a3cxcFlmZWdkVkY4d0VHZzY5dURqUEdQT0twUSsyNG9oNVNCekkyckkvZjBO?=
 =?utf-8?B?dk8rVFpxeld5bExLM0lxQ1VXWGxJVEtVa2NleUJFTUdBdHZiZHRzSHEzNWE2?=
 =?utf-8?B?SmZFOG9tek5sM29pWm9Gem5rY2RjaFEwUS9BM2MxajBOMmIyMC9wNW16eHQr?=
 =?utf-8?B?V3pzRC9Yb1NRYWZNN3hST0R4U0ZIb2wyYmF0WUNiZ1A3Rit1eEtab3YxK3lq?=
 =?utf-8?B?WHBtMXN6WjFxNXhCcGg3aUg0cHN2cWJjcnhpeFluWVdyZ2tlS1BDRDJienlY?=
 =?utf-8?B?S29rNXFsTjlOQ3hFbHNKRU0zODQ3S3laV3BJaktRWXpzR3dTWXFIbk50Zk0y?=
 =?utf-8?B?ZDAzRy9hTkQ4QUsxT01zei9GemxSUW1PUDdHdmVSNHVSVjJsc3lPaFJuZHYw?=
 =?utf-8?B?c3VhdUdVTytuZWtMYzJnRjFUZ3dVcEFjdjdZd045WGZLMlhybU5kTHdsQWZ0?=
 =?utf-8?B?TkZOdVNHNmpTWGxrckd1Vm8zbitCWW5OQjJLL0pSd0dqNVdEQi9EckpCVzdL?=
 =?utf-8?B?RUpoUzZjbzVlZUEwcHRzQlBxbjVuNWdEN1BNaDY3RjAxazZZT2MwcHR4MkFN?=
 =?utf-8?B?Q3hxUVBxTGtPS0Q0Sm9neGl6MU1MZGY1a050K2JzSzk5Rk11L0E2OUh2UmRN?=
 =?utf-8?B?UG9wd2lPOHVrcGdqenZtckRuNFIwc3RZdHFkbmJYcTJoRUNDei9JQzBScFhR?=
 =?utf-8?B?cUhPMXZkTXowR1ZhTXJXZFE1QXh6WWhJRjY4WjVSWXBacEQ5RXR0NlRwZ09O?=
 =?utf-8?B?R2tQZVFQcDVGSTdVVlZIN2J5clRoc0NqSFN5UUt0OFNYcStQcTFRWDhkbmN5?=
 =?utf-8?B?ZE9BU1J3VjhBOE52VEJ3aUw0NGtvMDE1bGhYYWo5T1I5K1I1QVhiblJYaTVh?=
 =?utf-8?B?TTlndW1YalJVQ2J3OW1hTm9DNGxDd085YTB6T1BWUWxZejZxZlBaT043QjhJ?=
 =?utf-8?B?ZmJWamh6M2MvNVpMSktSNDJHbi9KUkUzdmxuM1d6S1Ruc0dKTklEZUhqaVpI?=
 =?utf-8?B?cGVnSWN6MFJGYzlQUWRFWmxZQ3hncGwrQUZvVmMvamtIbEJnUE9ETWdKbi9U?=
 =?utf-8?B?WjE0R25nYWlSbXVNQnJEbE00OVBxVjY3VlhUU3Ywc1JRTEhURWxPS2VuNzdR?=
 =?utf-8?B?WW9jcDRaOHozZDNJKzVGZ2p5Uk1GSlpYK2NhVG0rS2NFN1BkZEpYdVlYYkdn?=
 =?utf-8?B?TjFKNjBNVTY3UGFyYUJJLzE0QnkyMHZzZk80NTBLMFN5bGVJZVFzUTM1bFRC?=
 =?utf-8?B?YmtzM2Q4SVNseEh1V3hHZG0wZCs0cEF0WDVLcGtSNGM3MmZ3YnBJNzlyMUN0?=
 =?utf-8?Q?/jNdmPAdADQD9G0138gJC6k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?TWJOOG42bGVzZU9hMXpzM0JDNHlFWWdVVkhaRU5UbktSRG5MUkFwZWRsYTJL?=
 =?utf-8?B?TEdrTVJiUG8vRG5uR3l3OWJwSzdDVEVZT0hWRE1OMVR1cVBqN2V1QzNOZlF4?=
 =?utf-8?B?MXFTQS9DZk5STnNjaGtqbWtwMTBMMTllZlF5c2t3U3BxRjZWclV5MG1zRW1Z?=
 =?utf-8?B?M2NHaDhKRnZyV3VpSUVGVW00OTZxRGFWV0NwVW9RQW5pS2xBSXZ3OXY1NWxv?=
 =?utf-8?B?c1pHWWJ6cGhueDBVMXc2OVg4QVo4OVpGOEtqMEVNZ0ZsTjF1VUlnZGcvZUwx?=
 =?utf-8?B?VlRPVnBLSjBIS3Y5SVJPaDVURUdFeTYvaXR0c3hhK25zcUtvaHpQOXBRN1d0?=
 =?utf-8?B?S0VuRlhESldFaTB6VkdFNElTRFZtZWxORmFMakovS0U3ZU1tRlVoZEV1K3VQ?=
 =?utf-8?B?TjFsOWJNVTVIZkxwM1pCSnFWU1ZFQ25peGhPVUhab2JCc1d5ZzUzdVF6ME40?=
 =?utf-8?B?QlVYWFlDbkhqOG1VK1VuM3dTbHpLeDZtL2Vqam5Sb3l0SHY2SDFwb05RajNx?=
 =?utf-8?B?V05SWllsN1NyRVhYdCtZdlIxSU9rZ2JtN1F5Z1NPOWZTSDlLRXF5WUtKYWor?=
 =?utf-8?B?MW44bHg2ck9lK3FxRjRuUWF3N1N6eEJCbm1YL0l3R2p0YnoxT0dBYkhEU240?=
 =?utf-8?B?WHF1RmRWVUJiZEVvTTNHSDBIaHFjOVBqc1RjRWZpcVlYNnY4aENidE1CYnZZ?=
 =?utf-8?B?bGpiUGJocDZTUU5Ob1ZaOWFKRVJoN1hNek5QT2dFNkxhNXJJNFZ1TUVSbjRq?=
 =?utf-8?B?ejhhN282eXRwdFhESzRuRjBtVFZWbEp2QU5LbTJScEJUdVdlNlk0QStyZTYz?=
 =?utf-8?B?UmFKU0RWVXVNWUxBRmNGLzJtb3p1bkowVUVDQlp0dS8zK1ZISnJKN2l2WDM0?=
 =?utf-8?B?UzNFZnZiNUZGL0gxUm1HY1M5RktZQWVtUEo2bld2ZXRoMWtoZnVDVm1YSWFL?=
 =?utf-8?B?SDV3ZDIvNERoWmZYOU10aEFJbUg2bW56UDA2dDF2czlaVXdwbjVqK2ZMdmdP?=
 =?utf-8?B?TlllcFZJM0pWU3dKa1F6Ym5tcWpicnd1eTBVRW9uK284Ry82Z0tiQyt2N0Zt?=
 =?utf-8?B?TThnNVI0NXp0Wk9kTmZZQkYxdmZEczVpL2ZJN0ZIM3dVeCtITG9UMmp6NWFJ?=
 =?utf-8?B?bW1UclZOYlYybTBKY09DRFNYMGUzeXBka3dtekEzZnlFeE5pKzVDSkp2MjhO?=
 =?utf-8?B?NVl2MXRqSTRUSTdlWUZmd2NhcHBKQnVNbU16akdzL2xLTUF2d01FZWlNZXE1?=
 =?utf-8?B?M0J5SnZBM1p6andLbW4rZ0RQYkpuL3MyTmZyN1h3TjBMMitsZz09?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7e7c10-8232-43bc-b99e-08db047cdd3f
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2023 17:50:53.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Spp7mZzS3mqWeySEMhh2Q/ujC7tvQCpxv8Y2Ca+nNrP5hNGGppy6RVhi5mVmJsEw4tAdnfi1mNsaCZLQFlq3Xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5665
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-02-01_04,2023-01-31_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 spamscore=0 phishscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2302010153
X-Proofpoint-GUID: PM_OLNMJQ2Q4kJozIWhGUd5WrBBECy98
X-Proofpoint-ORIG-GUID: PM_OLNMJQ2Q4kJozIWhGUd5WrBBECy98
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 01/02/2023 17:19, Arnaldo Carvalho de Melo wrote:
> Em Mon, Jan 30, 2023 at 02:29:42PM +0000, Alan Maguire escreveu:
>> This will be useful for postponing local function addition later on.
>> As part of this, store the type id offset and unspecified type in
>> the encoder, as this will simplify late addition of local functions.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  btf_encoder.c | 101 +++++++++++++++++++++++++++++++++-------------------------
>>  1 file changed, 57 insertions(+), 44 deletions(-)
>>
>> diff --git a/btf_encoder.c b/btf_encoder.c
>> index a5fa04a..44f1905 100644
>> --- a/btf_encoder.c
>> +++ b/btf_encoder.c
>> @@ -54,6 +54,8 @@ struct btf_encoder {
>>  	struct gobuffer   percpu_secinfo;
>>  	const char	  *filename;
>>  	struct elf_symtab *symtab;
>> +	uint32_t	  type_id_off;
>> +	uint32_t	  unspecified_type;
>>  	bool		  has_index_type,
>>  			  need_index_type,
>>  			  skip_encoding_vars,
>> @@ -593,20 +595,20 @@ static int32_t btf_encoder__add_func_param(struct btf_encoder *encoder, const ch
>>  	}
>>  }
>>  
>> -static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t type_id_off, uint32_t tag_type)
>> +static int32_t btf_encoder__tag_type(struct btf_encoder *encoder, uint32_t tag_type)
>>  {
>>  	if (tag_type == 0)
>>  		return 0;
>>  
>> -	if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
>> +	if (tag_type == encoder->unspecified_type) {
>>  		// No provision for encoding this, turn it into void.
>>  		return 0;
>>  	}
> 
> Humm, are those two lines (above) really equivalent? IIRC I read that as
> encoder->cu->unspecified_type.tag being zero means we still didn't set
> it, not that it is void (zero), right?
> 
> So if we're passing a tag_type zero, void, we'll return 0, i.e. turn
> into a void, so seems equivalent, try not to combine patches like this
> in the future, i.e. I would expect, from a quick glance, to have:
> 
> -     if (encoder->cu->unspecified_type.tag && tag_type == encoder->cu->unspecified_type.type) {
> +     if (encoder->unspecified_type && tag_type == encoder->unspecified_type) {
> 
> I.e. just the removal of the indirection thru encoder->cu. Or am I
> missing something here?
>

No, I don't think you're missing anything. I should have separated
out the changes that record encoder info such that we don't need to
rely on the current CU; we need those because now we interact with
functions potentially much later on, and the current CU can be
different. Ideally that would have come before this patch
refactoring function addition.

I can rework the series to do that if you like? Patch 5 will
need a bit of work too so that we can continue to support the
legacy behaviour, and we'll need an additional patch to support
switching the inconsistent prototype handling on also.
 
> - Arnaldo
> 
>>  
>> -	return type_id_off + tag_type;
>> +	return encoder->type_id_off + tag_type;
>>  }
>>  
>> -static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype, uint32_t type_id_off)
>> +static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct ftype *ftype)
>>  {
>>  	struct btf *btf = encoder->btf;
>>  	const struct btf_type *t;
>> @@ -616,7 +618,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>>  
>>  	/* add btf_type for func_proto */
>>  	nr_params = ftype->nr_parms + (ftype->unspec_parms ? 1 : 0);
>> -	type_id = btf_encoder__tag_type(encoder, type_id_off, ftype->tag.type);
>> +	type_id = btf_encoder__tag_type(encoder, ftype->tag.type);
>>  
>>  	id = btf__add_func_proto(btf, type_id);
>>  	if (id > 0) {
>> @@ -634,7 +636,7 @@ static int32_t btf_encoder__add_func_proto(struct btf_encoder *encoder, struct f
>>  	ftype__for_each_parameter(ftype, param) {
>>  		const char *name = parameter__name(param);
>>  
>> -		type_id = param->tag.type == 0 ? 0 : type_id_off + param->tag.type;
>> +		type_id = param->tag.type == 0 ? 0 : encoder->type_id_off + param->tag.type;
>>  		++param_idx;
>>  		if (btf_encoder__add_func_param(encoder, name, type_id, param_idx == nr_params))
>>  			return -1;
>> @@ -762,6 +764,31 @@ static int32_t btf_encoder__add_decl_tag(struct btf_encoder *encoder, const char
>>  	return id;
>>  }
>>  
>> +static int32_t btf_encoder__add_func(struct btf_encoder *encoder, struct function *fn)
>> +{
>> +	int btf_fnproto_id, btf_fn_id, tag_type_id;
>> +	struct llvm_annotation *annot;
>> +	const char *name;
>> +
>> +	btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto);
>> +	name = function__name(fn);
>> +	btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
>> +	if (btf_fnproto_id < 0 || btf_fn_id < 0) {
>> +		printf("error: failed to encode function '%s'\n", function__name(fn));
>> +		return -1;
>> +	}
>> +	list_for_each_entry(annot, &fn->annots, node) {
>> +		tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id,
>> +							annot->component_idx);
>> +		if (tag_type_id < 0) {
>> +			fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
>> +				annot->value, name, annot->component_idx);
>> +			return -1;
>> +		}
>> +	}
>> +	return 0;
>> +}
>> +
>>  /*
>>   * This corresponds to the same macro defined in
>>   * include/linux/kallsyms.h
>> @@ -859,22 +886,21 @@ static void dump_invalid_symbol(const char *msg, const char *sym,
>>  	fprintf(stderr, "PAHOLE: Error: Use '--btf_encode_force' to ignore such symbols and force emit the btf.\n");
>>  }
>>  
>> -static int tag__check_id_drift(const struct tag *tag,
>> -			       uint32_t core_id, uint32_t btf_type_id,
>> -			       uint32_t type_id_off)
>> +static int tag__check_id_drift(struct btf_encoder *encoder, const struct tag *tag,
>> +			       uint32_t core_id, uint32_t btf_type_id)
>>  {
>> -	if (btf_type_id != (core_id + type_id_off)) {
>> +	if (btf_type_id != (core_id + encoder->type_id_off)) {
>>  		fprintf(stderr,
>>  			"%s: %s id drift, core_id: %u, btf_type_id: %u, type_id_off: %u\n",
>>  			__func__, dwarf_tag_name(tag->tag),
>> -			core_id, btf_type_id, type_id_off);
>> +			core_id, btf_type_id, encoder->type_id_off);
>>  		return -1;
>>  	}
>>  
>>  	return 0;
>>  }
>>  
>> -static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct tag *tag, uint32_t type_id_off)
>> +static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct tag *tag)
>>  {
>>  	struct type *type = tag__type(tag);
>>  	struct class_member *pos;
>> @@ -896,7 +922,8 @@ static int32_t btf_encoder__add_struct_type(struct btf_encoder *encoder, struct
>>  		 * is required.
>>  		 */
>>  		name = class_member__name(pos);
>> -		if (btf_encoder__add_field(encoder, name, type_id_off + pos->tag.type, pos->bitfield_size, pos->bit_offset))
>> +		if (btf_encoder__add_field(encoder, name, encoder->type_id_off + pos->tag.type,
>> +					   pos->bitfield_size, pos->bit_offset))
>>  			return -1;
>>  	}
>>  
>> @@ -936,11 +963,11 @@ static int32_t btf_encoder__add_enum_type(struct btf_encoder *encoder, struct ta
>>  	return type_id;
>>  }
>>  
>> -static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag, uint32_t type_id_off,
>> +static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>>  				   struct conf_load *conf_load)
>>  {
>>  	/* single out type 0 as it represents special type "void" */
>> -	uint32_t ref_type_id = tag->type == 0 ? 0 : type_id_off + tag->type;
>> +	uint32_t ref_type_id = tag->type == 0 ? 0 : encoder->type_id_off + tag->type;
>>  	struct base_type *bt;
>>  	const char *name;
>>  
>> @@ -970,7 +997,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>>  		if (tag__type(tag)->declaration)
>>  			return btf_encoder__add_ref_type(encoder, BTF_KIND_FWD, 0, name, tag->tag == DW_TAG_union_type);
>>  		else
>> -			return btf_encoder__add_struct_type(encoder, tag, type_id_off);
>> +			return btf_encoder__add_struct_type(encoder, tag);
>>  	case DW_TAG_array_type:
>>  		/* TODO: Encode one dimension at a time. */
>>  		encoder->need_index_type = true;
>> @@ -978,7 +1005,7 @@ static int btf_encoder__encode_tag(struct btf_encoder *encoder, struct tag *tag,
>>  	case DW_TAG_enumeration_type:
>>  		return btf_encoder__add_enum_type(encoder, tag, conf_load);
>>  	case DW_TAG_subroutine_type:
>> -		return btf_encoder__add_func_proto(encoder, tag__ftype(tag), type_id_off);
>> +		return btf_encoder__add_func_proto(encoder, tag__ftype(tag));
>>          case DW_TAG_unspecified_type:
>>  		/* Just don't encode this for now, converting anything with this type to void (0) instead.
>>  		 *
>> @@ -1281,7 +1308,7 @@ static bool ftype__has_arg_names(const struct ftype *ftype)
>>  	return true;
>>  }
>>  
>> -static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_t type_id_off)
>> +static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
>>  {
>>  	struct cu *cu = encoder->cu;
>>  	uint32_t core_id;
>> @@ -1366,7 +1393,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder, uint32_
>>  			continue;
>>  		}
>>  
>> -		type = var->ip.tag.type + type_id_off;
>> +		type = var->ip.tag.type + encoder->type_id_off;
>>  		linkage = var->external ? BTF_VAR_GLOBAL_ALLOCATED : BTF_VAR_STATIC;
>>  
>>  		if (encoder->verbose) {
>> @@ -1507,7 +1534,6 @@ void btf_encoder__delete(struct btf_encoder *encoder)
>>  
>>  int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct conf_load *conf_load)
>>  {
>> -	uint32_t type_id_off = btf__type_cnt(encoder->btf) - 1;
>>  	struct llvm_annotation *annot;
>>  	int btf_type_id, tag_type_id, skipped_types = 0;
>>  	uint32_t core_id;
>> @@ -1516,21 +1542,24 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  	int err = 0;
>>  
>>  	encoder->cu = cu;
>> +	encoder->type_id_off = btf__type_cnt(encoder->btf) - 1;
>> +	if (encoder->cu->unspecified_type.tag)
>> +		encoder->unspecified_type = encoder->cu->unspecified_type.type;
>>  
>>  	if (!encoder->has_index_type) {
>>  		/* cu__find_base_type_by_name() takes "type_id_t *id" */
>>  		type_id_t id;
>>  		if (cu__find_base_type_by_name(cu, "int", &id)) {
>>  			encoder->has_index_type = true;
>> -			encoder->array_index_id = type_id_off + id;
>> +			encoder->array_index_id = encoder->type_id_off + id;
>>  		} else {
>>  			encoder->has_index_type = false;
>> -			encoder->array_index_id = type_id_off + cu->types_table.nr_entries;
>> +			encoder->array_index_id = encoder->type_id_off + cu->types_table.nr_entries;
>>  		}
>>  	}
>>  
>>  	cu__for_each_type(cu, core_id, pos) {
>> -		btf_type_id = btf_encoder__encode_tag(encoder, pos, type_id_off, conf_load);
>> +		btf_type_id = btf_encoder__encode_tag(encoder, pos, conf_load);
>>  
>>  		if (btf_type_id == 0) {
>>  			++skipped_types;
>> @@ -1538,7 +1567,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  		}
>>  
>>  		if (btf_type_id < 0 ||
>> -		    tag__check_id_drift(pos, core_id, btf_type_id + skipped_types, type_id_off)) {
>> +		    tag__check_id_drift(encoder, pos, core_id, btf_type_id + skipped_types)) {
>>  			err = -1;
>>  			goto out;
>>  		}
>> @@ -1572,7 +1601,7 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  			continue;
>>  		}
>>  
>> -		btf_type_id = type_id_off + core_id;
>> +		btf_type_id = encoder->type_id_off + core_id;
>>  		ns = tag__namespace(pos);
>>  		list_for_each_entry(annot, &ns->annots, node) {
>>  			tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_type_id, annot->component_idx);
>> @@ -1585,8 +1614,6 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  	}
>>  
>>  	cu__for_each_function(cu, core_id, fn) {
>> -		int btf_fnproto_id, btf_fn_id;
>> -		const char *name;
>>  
>>  		/*
>>  		 * Skip functions that:
>> @@ -1616,27 +1643,13 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>>  				continue;
>>  		}
>>  
>> -		btf_fnproto_id = btf_encoder__add_func_proto(encoder, &fn->proto, type_id_off);
>> -		name = function__name(fn);
>> -		btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id, name, false);
>> -		if (btf_fnproto_id < 0 || btf_fn_id < 0) {
>> -			err = -1;
>> -			printf("error: failed to encode function '%s'\n", function__name(fn));
>> +		err = btf_encoder__add_func(encoder, fn);
>> +		if (err)
>>  			goto out;
>> -		}
>> -
>> -		list_for_each_entry(annot, &fn->annots, node) {
>> -			tag_type_id = btf_encoder__add_decl_tag(encoder, annot->value, btf_fn_id, annot->component_idx);
>> -			if (tag_type_id < 0) {
>> -				fprintf(stderr, "error: failed to encode tag '%s' to func %s with component_idx %d\n",
>> -					annot->value, name, annot->component_idx);
>> -				goto out;
>> -			}
>> -		}
>>  	}
>>  
>>  	if (!encoder->skip_encoding_vars)
>> -		err = btf_encoder__encode_cu_variables(encoder, type_id_off);
>> +		err = btf_encoder__encode_cu_variables(encoder);
>>  out:
>>  	encoder->cu = NULL;
>>  	return err;
>> -- 
>> 1.8.3.1
>>
> 
